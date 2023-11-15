<#
    .SYNOPSIS
        Unregisters the scheduled task associated with the PSJet installer.

    .DESCRIPTION
        The `Unregister-PSJetInstallerScheduledTask` function removes the scheduled task related 
        to the PSJet installer if it exists. The task is identified using the "\PSJet\" path 
        and name obtained from the `Get-InvocationScript` function or provided explicitly. 
        No action is taken if the task does not exist.

    .PARAMETER InstallerScript
        The path to the installer script. Optional; if not specified, the name is obtained using `Get-InvocationScript`.

    .EXAMPLE
        Unregister-PSJetInstallerScheduledTask

        Description
        -----------
        Attempts to unregister (remove) the scheduled task related to the PSJet installer.

    .NOTES
        - Ensure that the user has the appropriate permissions to remove a scheduled task in Windows.
        - The function will silently ignore cases where the scheduled task does not exist.
        - Ensure that other processes are not dependent on the existing scheduled task as it will be unregistered without confirmation.
#>
function Unregister-PSJetInstallerScheduledTask {
    param (
        [string]$InstallerScript
    )

    if (-not $InstallerScript) {
        $InstallerScript = Get-InvocationScript
    }

    $taskPath = "\PSJet\"
    $taskName = Get-Item $InstallerScript | Select-Object -ExpandProperty BaseName
    $installerScheduledTask = (Get-ScheduledTask -TaskPath $taskPath -TaskName $taskName -ErrorAction SilentlyContinue)

    if ($installerScheduledTask) {
        $installerScheduledTask | Unregister-ScheduledTask -Confirm:$false
    }
}