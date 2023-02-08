<#
    .SYNOPSIS
    This function registers an application to run as an administrator.

    .DESCRIPTION
    The Register-AppAsAdmin function sets the application to run as an administrator by modifying the registry key in the AppCompatFlags\Layers path. The function will create the necessary registry key if it does not already exist.

    .PARAMETER ApplicationFilename
    The name of the application file to be registered as an administrator.

    .EXAMPLE
    Register-AppAsAdmin -ApplicationFilename "Example.exe"

    This example will register the "Example.exe" application to run as an administrator.

    .NOTES
    The user must have sufficient privileges to modify the registry keys.
#>
function Register-AppAsAdmin {
    param (
        [Parameter(Mandatory)]
        [string]$ApplicationFilename
    )
    
    $path = "HKCU:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers"

    New-Item -Path $path -ErrorAction SilentlyContinue
    New-ItemProperty -Path $path -Name $ApplicationFilename -Value "RUNASADMIN" -Force
}