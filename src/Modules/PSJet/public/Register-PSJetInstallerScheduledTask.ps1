<#
    .SYNOPSIS
        Registers a new scheduled task in Windows Task Scheduler for the PSJet installer.

    .DESCRIPTION
        The `Register-PSJetInstallerScheduledTask` function creates a new scheduled task 
        that triggers the PSJet installer to run at logon with a delay of 15 seconds.
        The task is created under the "\PSJet\" path with the name obtained from the `Get-InvocationScript` function or provided explicitly.
        If a task with the same name already exists, the function will not create a new one.
        PowerShell scripts executed by the task are run with the Bypass execution policy and with the highest privileges.

    .PARAMETER InstallerScript
        The path to the installer script. Optional; if not specified, the path is obtained using `Get-InvocationScript`.

    .EXAMPLE
        Register-PSJetInstallerScheduledTask

        Description
        -----------
        Registers a new scheduled task for the PSJet installer with the specified properties.

    .NOTES
        - Ensure that the user has the appropriate permissions to create a scheduled task in Windows.
        - Tasks will be run with the highest privileges and bypass PowerShell's execution policy.
#>
function Register-PSJetInstallerScheduledTask {
    param (
        [string]$InstallerScript
    )

    if (-not $InstallerScript) {
        $InstallerScript = Get-InvocationScript
    }

    $taskPath = "\PSJet\"
    $taskName = Get-Item $InstallerScript | Select-Object -ExpandProperty BaseName
    $installerScheduledTask = (Get-ScheduledTask -TaskPath $taskPath -TaskName $taskName -ErrorAction SilentlyContinue)

    if ($null -eq $installerScheduledTask)
    {
        $trigger = New-ScheduledTaskTrigger -AtLogOn
        $trigger.Delay = "PT15S"
        $action = New-ScheduledTaskAction -Execute "pwsh.exe" -Argument "-ExecutionPolicy Bypass -Command `"& '$InstallerScript'`""
        
        $installerScheduledTask = Register-ScheduledTask -TaskPath $taskPath -TaskName $taskName -Trigger $trigger -Action $action -RunLevel Highest -Force
    }
}