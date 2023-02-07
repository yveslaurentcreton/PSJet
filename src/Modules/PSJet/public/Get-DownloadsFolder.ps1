<#
    .SYNOPSIS
    Gets the full path of the Downloads folder.

    .DESCRIPTION
    This function returns the full path of the Downloads folder as a string, using the Windows shell namespace and the Shell.Application COM object.

    .OUTPUTS
    System.String

    .EXAMPLE
    Get-DownloadsFolder

    C:\Users\<UserName>\Downloads

    .NOTES
    This function requires access to the Windows shell namespace and the Shell.Application COM object.

    .LINK
    https://docs.microsoft.com/en-us/dotnet/api/system.environment.getfolderpath
    https://docs.microsoft.com/en-us/windows/win32/shell/shell-namespace-shell-folder-constants
    https://docs.microsoft.com/en-us/windows/win32/shell/shell-folder
#>
function Get-DownloadsFolder {
    $downloadsFolder = (New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path

    return $downloadsFolder
}