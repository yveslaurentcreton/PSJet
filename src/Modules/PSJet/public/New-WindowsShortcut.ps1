<#
    .SYNOPSIS
    Creates a new Windows shortcut at the specified location with optional arguments.

    .DESCRIPTION
    This function creates a new shortcut file that points to the specified source file and can include additional arguments.
    It uses the WScript.Shell object to create and save the shortcut.

    .PARAMETER SourceFileLocation
    The path to the source file that the shortcut should point to. This is a mandatory parameter.

    .PARAMETER ShortcutLocation
    The path where the shortcut file should be saved. This is a mandatory parameter.

    .PARAMETER Arguments
    Optional command-line arguments to be included in the shortcut.

    .EXAMPLE
    New-WindowsShortcut -SourceFileLocation "C:\My Documents\ImportantFile.txt" -ShortcutLocation "C:\Desktop\ImportantFile.lnk"
    Creates a new shortcut on the desktop to the file "C:\My Documents\ImportantFile.txt".

    .EXAMPLE
    New-WindowsShortcut -SourceFileLocation "C:\Program Files\MyApp\MyApp.exe" -ShortcutLocation "C:\Desktop\MyApp.lnk" -Arguments "/silent"
    Creates a new shortcut on the desktop to the application "MyApp.exe" with the "/silent" argument.

    .NOTES
    This function requires the use of the WScript.Shell object and therefore only works on Windows systems.
#>
function New-WindowsShortcut {
    [CmdletBinding(SupportsShouldProcess=$True, ConfirmImpact='Low')]
    param (
        [Parameter(Mandatory)]
        [string]$SourceFileLocation,

        [Parameter(Mandatory)]
        [string]$ShortcutLocation,

        [string]$Arguments
    )

    if (!($PSCmdlet.ShouldProcess($ShortcutLocation, "Create Shortcut"))) {
        return
    }

    $WScriptShell = New-Object -ComObject WScript.Shell
    $Shortcut = $WScriptShell.CreateShortcut($ShortcutLocation)
    $Shortcut.TargetPath = $SourceFileLocation

    if ($null -ne $Arguments) {
        $Shortcut.Arguments = $Arguments
    }
    
    $Shortcut.Save()
}
