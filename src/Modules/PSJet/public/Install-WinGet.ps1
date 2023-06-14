<#
    .SYNOPSIS
    Installs the Windows Package Manager (winget) if it is not already installed.

    .DESCRIPTION
    This function installs the Windows Package Manager (winget) if it is not already installed on the system.

    .EXAMPLE
    PS> Install-WinGet
    winget installed successfully.

    .EXAMPLE
    PS> if (-not (Test-IsWinGetInstalled)) { Install-WinGet }
#>
function Install-WinGet {
    
    # Check if winget is already installed
    $wingetInstalled = Test-IsWinGetInstalled
    
    if (-not $wingetInstalled) {
        # Specify the GitHub repository details and the winget asset name
        $owner = "Microsoft"
        $repository = "winget-cli"
        $asset = "Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
        
        Write-Host "Downloading and installing WinGet..."
        Install-GitHubRelease -Owner $owner -Repository $repository -Asset $asset
        
        # Verify installation
        $wingetInstalled = Test-IsWinGetInstalled
        
        if ($wingetInstalled) {
            Write-Host 'WinGet installed successfully.'
        } else {
            Write-Host 'Failed to install WinGet.'
        }
    } else {
        Write-Host 'WinGet is already installed.'
    }
}