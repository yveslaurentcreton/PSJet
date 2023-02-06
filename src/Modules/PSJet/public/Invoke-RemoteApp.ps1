<#
    .SYNOPSIS
    This function allows the user to launch a remote application on a remote computer.

    .DESCRIPTION
    The function creates a Remote Desktop Protocol (.rdp) file and launches it with the specified ComputerName, UserName, and Application parameters.
    The .rdp file is generated using a template that is configured with the specified parameters, including the remote computer name, username, and the application to run on the remote computer.
    The generated .rdp file is stored in a temporary location and then launched, allowing the user to connect to the remote computer and run the specified application.

    .PARAMETER ComputerName
    The name or IP address of the remote computer to connect to.

    .PARAMETER UserName
    The username to use for the remote connection.

    .PARAMETER Application
    The application to run on the remote computer.

    .NOTES
    This function requires the Remote Desktop Connection client to be installed on the local machine.

    .EXAMPLE
    Invoke-RemoteApp -ComputerName "RemoteComputer" -UserName "Administrator" -Application "notepad.exe"
    Launches Notepad on the remote computer named "RemoteComputer" using the specified username.
#>
function Invoke-RemoteApp {
    param (
        [Parameter(Mandatory)]
        [string]$ComputerName,
        [Parameter(Mandatory)]
        [string]$UserName,
        [Parameter(Mandatory)]
        [string]$Application
    )

    $remoteAppContent = @"
screen mode id:i:1
use multimon:i:0
desktopwidth:i:3840
desktopheight:i:2160
session bpp:i:32
winposstr:s:0,1,0,0,800,600
compression:i:1
keyboardhook:i:2
audiocapturemode:i:0
videoplaybackmode:i:1
connection type:i:7
networkautodetect:i:1
bandwidthautodetect:i:1
displayconnectionbar:i:1
enableworkspacereconnect:i:0
disable wallpaper:i:0
allow font smoothing:i:0
allow desktop composition:i:0
disable full window drag:i:1
disable menu anims:i:1
disable themes:i:0
disable cursor setting:i:0
bitmapcachepersistenable:i:1
full address:s:[[computerName]]
audiomode:i:0
redirectprinters:i:1
redirectcomports:i:0
redirectsmartcards:i:1
redirectclipboard:i:1
redirectposdevices:i:0
drivestoredirect:s:
autoreconnection enabled:i:1
authentication level:i:2
prompt for credentials:i:0
negotiate security layer:i:1
remoteapplicationmode:i:1
remoteapplicationprogram:s:[[application]]
alternate shell:s:
shell working directory:s:
gatewayhostname:s:
gatewayusagemethod:i:4
gatewaycredentialssource:i:4
gatewayprofileusagemethod:i:0
promptcredentialonce:i:0
gatewaybrokeringtype:i:0
use redirection server name:i:0
rdgiskdcproxy:i:0
kdcproxyname:s:
username:s:[[userName]]
"@

    $content = $remoteAppContent;
    $content = $content.Replace("[[computerName]]", $ComputerName);
    $content = $content.Replace("[[userName]]", $UserName);
    $content = $content.Replace("[[application]]", $Application);

    # Generate rdp filename
    $tmpFile = New-TemporaryFile
    Remove-Item $tmpFile.FullName
    $rdpFileName = $tmpFile.FullName.Replace("tmp", "rdp")

    # Save rdp file
    Set-Content -Path $rdpFileName -Value $content -Force

    # Run rdp file
    . $rdpFileName
}