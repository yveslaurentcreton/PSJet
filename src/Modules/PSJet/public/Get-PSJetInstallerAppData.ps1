<#
    .SYNOPSIS
        Gets application data paths related to PSJet Installer.

    .DESCRIPTION
        The function retrieves and constructs paths for application data folders and state files,
        which are used in the PSJet Installer to store and retrieve states.

    .EXAMPLE
        $appData = Get-PSJetInstallerAppData

        Description
        -----------
        Retrieves application data paths and stores them in the $appData variable.

    .OUTPUTS
        PSCustomObject
        Returns a custom object with properties specifying paths to various app data.
#>
function Get-PSJetInstallerAppData {
    $folderPath = Join-Path -Path $env:LOCALAPPDATA -ChildPath 'PSJet\Installer'
    $stateJsonPath = Join-Path -Path $folderPath -ChildPath 'state.json'

    return @{
        FolderPath = $folderPath
        StateJsonPath = $stateJsonPath
    }
}