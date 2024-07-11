<#
    .SYNOPSIS
    Retrieves the host name of the virtual machine.

    .DESCRIPTION
    The Get-HostName function retrieves the host name of the virtual machine by accessing the "HostName" value in the "HKLM:\SOFTWARE\Microsoft\Virtual Machine\Guest\Parameters" registry key.

    .EXAMPLE
    Get-HostName

    This example returns the host name of the virtual machine.

    .OUTPUTS
    System.String. The host name of the virtual machine.

    .NOTES
    None.

    .FUNCTIONALITY
    Retrieving host name from registry key.
#>
function Get-HostName{
    $hostName = (Get-Item "HKLM:\SOFTWARE\Microsoft\Virtual Machine\Guest\Parameters").GetValue("HostName")

    return $hostName;
}