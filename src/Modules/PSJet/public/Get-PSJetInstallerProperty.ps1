<#
.SYNOPSIS
    Retrieves a property value from the PSJet Installer state.

.DESCRIPTION
    The `Get-PSJetInstallerProperty` function retrieves a property value from the PSJet Installer state.
    If the property does not exist, a warning is issued and $null is returned.

.PARAMETER Name
    Specifies the name of the property to be retrieved.

.EXAMPLE
    $installationDate = Get-PSJetInstallerProperty -Name "InstallationDate"

    Description
    -----------
    Retrieves the value of the `InstallationDate` property and stores it in the `$installationDate` variable.

.NOTES
    Ensure that you handle potential $null values in your implementation logic when retrieving properties that may not exist.
#>
function Get-PSJetInstallerProperty {
    param (
        [Parameter(Mandatory=$true)]
        [string]$Name
    )

    # Get state
    $state = Get-PSJetInstallerState

    # Return the property value or $null if it doesn't exist
    if ($state.PSObject.Properties.Name -contains $Name) {
        return $state.$Name
    } else {
        Write-Warning "Property [$Name] does not exist in the state."
        return $null
    }
}
