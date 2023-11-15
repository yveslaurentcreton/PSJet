<#
    .SYNOPSIS
    Installs a Microsoft Installer (MSI) package.

    .DESCRIPTION
    The Install-MSI function provides a way to install MSI packages silently. It uses the msiexec.exe utility
    which is a command-line interface for the Windows Installer. The function installs the specified MSI package
    with silent installation options, meaning no user interaction and no interface will be displayed during installation.

    .PARAMETER FilePath
    The full path to the MSI file that needs to be installed.

    .EXAMPLE
    Install-MSI -FilePath "C:\Downloads\example.msi"

    .NOTES
    The function requires administrative privileges to install MSI packages.
    Ensure that the path to the MSI file is correct and accessible.

    .LINK
    https://docs.microsoft.com/en-us/windows/win32/msi/command-line-options
#>
function Install-MSI {
    param (
        [Parameter(Mandatory)]
        [string]$FilePath
    )

    # Check if the file exists
    if (-not (Test-Path -Path $FilePath)) {
        Write-Error "MSI file not found at the specified path: $FilePath"
        return
    }

    # Install the MSI package silently
    try {
        Start-Process "msiexec.exe" -ArgumentList "/i `"$FilePath`" /quiet /norestart" -Wait -NoNewWindow
    } catch {
        Write-Error "Failed to install MSI package: $_"
    }
}
