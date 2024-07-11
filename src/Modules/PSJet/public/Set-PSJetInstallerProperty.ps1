<#
.SYNOPSIS
    Sets or updates a property in the PSJet Installer state.

.DESCRIPTION
    The `Set-PSJetInstallerProperty` function sets or updates a property in the PSJet Installer state.
    If the property does not exist, it is added. If it does exist, its value is updated.

.PARAMETER Name
    Specifies the name of the property to be set or updated.

.PARAMETER Value
    Specifies the value to be assigned to the property.

.EXAMPLE
    Set-PSJetInstallerProperty -Name "InstallationDate" -Value (Get-Date)

    Description
    -----------
    Sets the property `InstallationDate` with the current date and time.

.NOTES
    If you modify the state inside this function, ensure to call a function to save the state afterwards if persistent storage is desired.
#>
function Set-PSJetInstallerProperty {
    param (
        [Parameter(Mandatory=$true)]
        [string]$Name,
        
        [Parameter(Mandatory=$true)]
        [object]$Value
    )

    # Get state
    $state = Get-PSJetInstallerState

    # Check if the property already exists
    if ($state.PSObject.Properties.Name -contains $Name) {
        # If exists, update the value
        $state.$Name = $Value
    } else {
        # If not exists, add the property
        $state | Add-Member -MemberType NoteProperty -Name $Name -Value $Value -Force
    }
}
