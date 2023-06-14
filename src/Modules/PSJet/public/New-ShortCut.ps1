<#
    .SYNOPSIS
    Creates a new shortcut at the specified location.

    .DESCRIPTION
    This function creates a new shortcut file that points to the specified source file.
    It uses the WScript.Shell object to create the shortcut and save it to the specified location.

    .PARAMETER SourceFileLocation
    The path to the source file that the shortcut should point to. This is a mandatory parameter.

    .PARAMETER ShortcutLocation
    The path where the shortcut file should be saved. This is a mandatory parameter.

    .EXAMPLE
    New-Shortcut -SourceFileLocation "C:\My Documents\ImportantFile.txt" -ShortcutLocation "C:\Desktop\ImportantFile.lnk"
    Creates a new shortcut on the desktop to the file "C:\My Documents\ImportantFile.txt".

    .NOTES
    This function requires the use of the WScript.Shell object and therefore only works on Windows systems.
#>
function New-Shortcut {
    [CmdletBinding(SupportsShouldProcess=$True, ConfirmImpact='Low')]
    param (
        [Parameter(Mandatory)]
        [string]$SourceFileLocation,
        [Parameter(Mandatory)]
        [string]$ShortcutLocation
    )

    if (!(ShouldProcess $ShortcutLocation "Create Shortcut")) {
        return
    }

    $WScriptShell = New-Object -ComObject WScript.Shell
    $Shortcut = $WScriptShell.CreateShortcut($ShortcutLocation)
    $Shortcut.TargetPath = $SourceFileLocation
    $Shortcut.Save()
}
