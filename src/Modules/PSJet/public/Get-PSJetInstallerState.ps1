<#
    .SYNOPSIS
        Retrieves the current state of PSJet Installer.

    .DESCRIPTION
        Retrieves the current state of PSJet Installer. If no state is set,
        it initializes the state by calling Initialize-PSJetInstallerState function.

    .EXAMPLE
        $state = Get-PSJetInstallerState

        Description
        -----------
        Retrieves the current state and stores it in the $state variable.

    .OUTPUTS
        PSCustomObject
        Returns a custom object representing the current state of the installer.
#>
function Get-PSJetInstallerState {
    if (-Not $Script:State) {
        Initialize-PSJetInstallerState
    }

    return $Script:State
}
