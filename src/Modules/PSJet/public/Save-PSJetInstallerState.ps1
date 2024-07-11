<#
    .SYNOPSIS
        Saves the current state of PSJet Installer to a JSON file.

    .DESCRIPTION
        The function converts the state into JSON format and saves it to state.json.

    .EXAMPLE
        Save-PSJetInstallerState

        Description
        -----------
        Saves the current state to state.json.
#>
function Save-PSJetInstallerState {
    $appData = Get-PSJetInstallerAppData
    $state = Get-PSJetInstallerState
    $state | ConvertTo-Json | Set-Content -Path $appData.StateJsonPath -Force
}
