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

    .NOTES
        State should be stored in the $Script:State variable.
#>
function Save-PSJetInstallerState {
    $appData = Get-PSJetInstallerAppData
    $Script:State | ConvertTo-Json | Set-Content -Path $appData.StateJsonPath -Force
}
