<#
    .SYNOPSIS
    Gets the first IP address of a running virtual machine.

    .DESCRIPTION
    This function retrieves all running virtual machines, filters out their network adapters and expands the IPAddresses property to get the first IP address.

    .EXAMPLE
    PS C:\> Get-VMIpAddress

    Output:
    10.0.0.5

    .NOTES
    This function assumes that virtual machines have at least one network adapter and that the adapter has an assigned IP address.
#>
function Get-VMIpAddress {
    Get-VM | Where-Object State -eq Running | Select-Object NetworkAdapters -ExpandProperty NetworkAdapters | Select-Object IPAddresses -ExpandProperty IPAddresses | Select-Object -First 1
}