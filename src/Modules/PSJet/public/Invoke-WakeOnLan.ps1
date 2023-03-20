<#
    .SYNOPSIS
    Sends a Wake-on-LAN magic packet to the specified MAC address.

    .DESCRIPTION
    This script sends a Wake-on-LAN magic packet to a device with the specified MAC address.
    It iterates through all available network interfaces, checks if they are operational,
    and sends the magic packet from the local IP address associated with each interface.

    .PARAMETER MacAddress
    The MAC address of the target device that should be woken up.

    .EXAMPLE
    Invoke-WakeOnLan -MacAddress "00:11:22:33:44:55"
#>
function Invoke-WakeOnLan {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidatePattern('^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$')]
        [string]$MacAddress
    )
    # Get all network interfaces
    $networkInterfaces = [System.Net.NetworkInformation.NetworkInterface]::GetAllNetworkInterfaces()

    # Filter out loopback and non-operational interfaces
    $operationalInterfaces = $networkInterfaces | Where-Object {
        $_.NetworkInterfaceType -ne [System.Net.NetworkInformation.NetworkInterfaceType]::Loopback -and
        $_.OperationalStatus -eq [System.Net.NetworkInformation.OperationalStatus]::Up
    }

    # Iterate through each operational interface
    foreach ($networkInterface in $operationalInterfaces) {
        # Get the local IP address for the current interface
        $localIpAddress = ($networkInterface.GetIPProperties().UnicastAddresses |
            Where-Object { $_.Address.AddressFamily -eq [System.Net.Sockets.AddressFamily]::InterNetwork })[0].Address

        # Parse and clean the target MAC address
        $targetPhysicalAddress = [System.Net.NetworkInformation.PhysicalAddress]::Parse(($MacAddress.ToUpper() -replace '[^0-9A-F]', ''))

        # Get the target physical address bytes
        $targetPhysicalAddressBytes = $targetPhysicalAddress.GetAddressBytes()

        # Create the magic packet
        $packet = [byte[]](, 0xFF * 102)
        for ($i = 6; $i -le 101; $i++) {
            $packet[$i] = $targetPhysicalAddressBytes[($i % 6)]
        }

        # Define the local and target endpoints
        $localEndpoint = [System.Net.IPEndPoint]::new($localIpAddress, 0)
        $targetEndpoint = [System.Net.IPEndPoint]::new([System.Net.IPAddress]::Broadcast, 9)

        # Create a UDP client and send the magic packet
        $client = [System.Net.Sockets.UdpClient]::new($localEndpoint)
        try {
            $client.Send($packet, $packet.Length, $targetEndpoint) | Out-Null
        }
        finally {
            $client.Dispose()
        }
    }
}
