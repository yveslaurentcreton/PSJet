<#
    .SYNOPSIS
    Adds a host to the list of trusted hosts.

    .DESCRIPTION
    The Add-TrustedHost function adds a host to the list of trusted hosts in the WSMan configuration. The host name is passed as a mandatory parameter. The function uses the Set-Item cmdlet to set the "TrustedHosts" value in the "WSMan:\localhost\Client" path, with the specified host name and the "Force" switch to overwrite any existing values.

    .EXAMPLE
    Add-TrustedHost -HostName "host.example.com"

    This example adds the "host.example.com" to the list of trusted hosts.

    .OUTPUTS
    None.

    .NOTES
    Adding a host to the list of trusted hosts can affect the security of your system, as it allows for remote management of the host by a trusted host. Use this cmdlet with caution.

    .FUNCTIONALITY
    Adding a host to the list of trusted hosts in the WSMan configuration.
#>
function Add-TrustedHost {
    param (
        [Parameter(Mandatory)]
        [string]$HostName
    )

    Set-Item WSMan:\localhost\Client\TrustedHosts -Value $HostName -Force
}