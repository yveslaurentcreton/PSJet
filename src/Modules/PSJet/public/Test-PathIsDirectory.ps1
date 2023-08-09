<#
    .SYNOPSIS
    Determines if the provided path is likely a directory path based on the absence of an extension.

    .DESCRIPTION
    This function checks if the specified path lacks an extension, typically indicating it's a directory.

    .PARAMETER Path
    The path that you want to check.

    .EXAMPLE
    Test-PathIsDirectory -Path "C:\example\foldername"
    This will return $true as the provided path lacks an extension, indicating it's likely a directory.

    .EXAMPLE
    Test-PathIsDirectory -Path "C:\example\myfile.txt"
    This will return $false as the provided path has an extension, indicating it's likely not a directory.
#>
function Test-PathIsDirectory {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$Path
    )

    return (-not (Test-PathHasExtension -Path $Path))
}
