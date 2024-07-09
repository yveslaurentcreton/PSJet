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

        # Get the download folder
        $downloadFolder = Get-DownloadsFolder

        # Download and install dependencies
        Write-Host "Downloading and installing dependencies for WinGet..."

        # Determine if PowerShell version is less than 7
        $psVersion = $PSVersionTable.PSVersion
        
        # Download and install Microsoft.VCLibs.x64.14.00.Desktop.appx
        $vclibsPath = Join-Path -Path $downloadFolder -ChildPath "Microsoft.VCLibs.x64.14.00.Desktop.appx"
        Invoke-WebRequest -Uri https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx -OutFile $vclibsPath
        Add-AppxPackage $vclibsPath

        # Download and install Microsoft.UI.Xaml.2.8.x64.appx
        Install-GitHubRelease -Owner "Microsoft" -Repository "microsoft-ui-xaml" -Tag "v2.8.6" -Asset "Microsoft.UI.Xaml.2.8.x64.appx"
        
        # Install winget
        Write-Host "Installing WinGet..."

        Install-GitHubRelease -Owner "Microsoft" -Repository "winget-cli" -Asset "Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
        
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
