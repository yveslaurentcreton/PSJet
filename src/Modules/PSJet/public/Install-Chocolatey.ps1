<#
    .SYNOPSIS
    Installs the Chocolatey package manager.

    .DESCRIPTION
    The Install-Chocolatey function installs the Chocolatey package manager, which is a package manager for Windows that allows for easy installation and management of software packages. The function checks if Chocolatey is already installed and installs it if it's not.

    .PARAMETER NoAdmin
    Specifies whether to install Chocolatey without requiring administrative privileges. If specified, the installation will be performed in the user's context without requiring elevation.

    .EXAMPLE
    Install-Chocolatey

    This example will install Chocolatey with administrative privileges.

    .EXAMPLE
    Install-Chocolatey -NoAdmin

    This example installs Chocolatey without requiring administrative privileges.

    .NOTES
    The user must have administrative privileges to install Chocolatey with administrative privileges. If NoAdmin is specified, the installation will be performed in the user's context without requiring elevation.
#>
function Install-Chocolatey {
    param (
        [switch]$NoAdmin
    )

    # Check if Chocolatey is already installed
    $chocolateyInstalled = Test-IsChocolateyInstalled

    if (-not $chocolateyInstalled)
    {
        if ($NoAdmin) {
            Write-Host 'Installing Chocolatey without administrative privileges...'
            
            # Set directory for installation - Chocolatey does not lock
            # down the directory if not the default
            $InstallDir='C:\ProgramData\chocoportable'
            $env:ChocolateyInstall="$InstallDir"

            # If your PowerShell Execution policy is restrictive, you may
            # not be able to get around that. Try setting your session to
            # Bypass.
            Set-ExecutionPolicy Bypass -Scope Process -Force;
        } else {
            Write-Host 'Installing Chocolatey...'
        }
        
        # Download and execute the installation script
        iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

        # Verify installation
        $chocolateyInstalled = Test-IsChocolateyInstalled

        if ($chocolateyInstalled) {
            Write-Host 'Chocolatey installed successfully.'
        } else {
            Write-Host 'Failed to install Chocolatey.'
        }
    }
    else
    {
        Write-Host 'Chocolatey is already installed.'
    }
}
