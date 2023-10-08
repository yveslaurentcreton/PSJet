<#
    .SYNOPSIS
        Initiates the PSJet installer process, executing scripts sequentially with optional restarts and persistent state across restarts.

    .DESCRIPTION
        The `Invoke-PSJetInstaller` function orchestrates a sequential execution of installation step scripts, 
        handling script state management, optional self-elevation for administrative privileges, 
        and conditional system restarts with installation state persistence.

        When `EnableRestart` is specified, the function ensures that the installer continues from the last step 
        after a system restart by registering a scheduled task to re-invoke the installer on user logon. 
        The scheduled task will be unregistered upon successful installation completion.

    .PARAMETER AsAdmin
        If specified, the installer attempts to self-elevate to run with administrative privileges using the `Invoke-ElevateAsAdmin` function.

    .PARAMETER EnableRestart
        If specified, enables handling of system restarts and ensures the installation continues 
        from the last step by leveraging scheduled tasks, registered, and unregistered by `Register-PSJetInstallerScheduledTask`
        and `Unregister-PSJetInstallerScheduledTask` respectively.

    .EXAMPLE
        Invoke-PSJetInstaller -AsAdmin -EnableRestart

        Description
        -----------
        Initiates the installer ensuring administrative privileges and enabling handling and persistence through system restarts.

    .NOTES
        - Installation step scripts should reside in "$installerDirectory\Steps\".
        - Scripts must be named to enforce execution order (e.g., 01-FirstStep.ps1, 02-SecondStep.ps1).
        - Step scripts use `$Script:State` for state management and persistence across restarts.
        - A step script can request a system restart by assigning `$true` to `$Script:State.restartComputer`.
        - User prompts on restart can be suppressed by assigning `$true` to `$Script:State.autoRestartComputer`.
        - The `Invoke-ElevateAsAdmin`, `Register-PSJetInstallerScheduledTask`, and `Unregister-PSJetInstallerScheduledTask` functions 
        should be defined and accessible within the scope of `Invoke-PSJetInstaller`.

    .OUTPUTS
        None. Outputs to host and might restart the computer, terminating the PowerShell session.

    .INPUTS
        None. All inputs are handled through parameters.
#>
function Invoke-PSJetInstaller {
    param (
        [Parameter()]
        [switch]$AsAdmin,
        [Parameter()]
        [switch]$EnableRestart
    )

    # Self-elevate the script if required
    if ($AsAdmin) {
        Invoke-ElevateAsAdmin
    }

    # Schedule the installer to run at logon
    if ($EnableRestart) {
        Register-PSJetInstallerScheduledTask
    }

    # Set state
    $steps = Get-ChildItem -Path "$installerDirectory\Steps\*.ps1" | Sort-Object FullName
    $firstStep = $steps | Select-Object -First 1 | Select-Object -ExpandProperty FullName
    $state = Get-PSJetInstallerState
    $state.step = $firstStep
    $nextStep = $state.step

    while ($null -ne $nextStep) {

        # Set current step
        $currentStep = $nextStep

        # Execute current step
        & $currentStep

        # Determine next step
        $nextStep = ($steps | Where-Object FullName -gt $currentStep | Select-Object -First 1)
        $state.step = $nextStep

        # Restart computer if required
        if ($EnableRestart -and $state.restartComputer) {
            
            $state.restartComputer = $false
            Save-PSJetInstallerState

            Write-Warning 'The installer will continue after the computer is restarted. The computer will now restart.' -WarningAction Continue

            if (-Not $state.autoRestartComputer) {
                Show-KeyPressPrompt -Message 'Press any key to restart the computer...'
            }

            Restart-Computer -Force
            return
        }
    }

    if ($EnableRestart) {
        Unregister-PSJetInstallerScheduledTask
    }

    Write-Information 'The software installation is completed.' -InformationAction Continue
    Show-KeyPressPrompt -Message 'Press any key to finish...'
}