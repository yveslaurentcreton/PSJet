<#
    .SYNOPSIS
    Determines if the provided path is likely a file path based on the presence of an extension.

    .DESCRIPTION
    This function checks if the specified path has an extension, typically indicating it's a file.

    .PARAMETER Path
    The path that you want to check.

    .EXAMPLE
    Test-PathIsFile -Path "C:\example\myfile.txt"
    This will return $true as the provided path has an extension, indicating it's likely a file.

    .EXAMPLE
    Test-PathIsFile -Path "C:\example\foldername"
    This will return $false as the provided path lacks an extension, indicating it's likely not a file.
#>
function Test-PathIsFile {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$Path
    )

    return (Test-PathHasExtension -Path $Path)
}
