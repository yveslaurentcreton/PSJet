<#
    .SYNOPSIS
    Determines if the provided path has an extension.

    .DESCRIPTION
    This function checks whether the specified path has an extension and returns a boolean value indicating the presence or absence of an extension.

    .PARAMETER Path
    The path that you want to check for an extension.

    .EXAMPLE
    Test-PathHasExtension -Path "C:\example\myfile.txt"
    This will return $true as the provided path has an extension.

    .EXAMPLE
    Test-PathHasExtension -Path "C:\example\foldername"
    This will return $false as the provided path does not have an extension.
#>
function Test-PathHasExtension {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$Path
    )

    $extension = [System.IO.Path]::GetExtension($Path)
    return (-not [string]::IsNullOrEmpty($extension))
}
