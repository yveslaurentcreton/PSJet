<#
    .SYNOPSIS
    Downloads a specific asset from a GitHub release.

    .DESCRIPTION
    This function downloads a specific asset from a GitHub release, based on the specified repository owner, repository name, asset name, and release tag (optional). If no tag is specified, the latest release will be used. The function uses the GitHub API to retrieve information about the release and the Invoke-WebRequest cmdlet to download the specified asset to a specified or default Downloads folder.

    .PARAMETER Owner
    The name of the repository owner.

    .PARAMETER Repository
    The name of the repository.

    .PARAMETER Asset
    The name of the asset to download.

    .PARAMETER Tag
    The tag name of the release. Optional; if not specified, the latest release will be used.

    .PARAMETER DownloadFolder
    The path to the folder where the asset will be downloaded. Optional; if not specified, the default Downloads folder will be used.

    .OUTPUTS
    String. The path of the downloaded file.

    .EXAMPLE
    Invoke-DownloadGitHubRelease -Owner "Microsoft" -Repository "PowerShell" -Asset "Microsoft.PowerShell.*.msi"

    .EXAMPLE
    Invoke-DownloadGitHubRelease -Owner "Microsoft" -Repository "PowerShell" -Asset "Microsoft.PowerShell.7.0.0-rc.1.msi" -Tag "v7.0.0-rc.1"

    .EXAMPLE
    Invoke-DownloadGitHubRelease -Owner "Microsoft" -Repository "PowerShell" -Asset "Microsoft.PowerShell.*.msi" -DownloadFolder "C:\MyCustomFolder"

    .NOTES
    This function requires access to the internet to download the asset from GitHub. Ensure that the provided DownloadFolder path exists and is writable.

    .LINK
    https://docs.github.com/en/rest/releases/releases
    https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/invoke-restmethod?view=powershell-7.2
    https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/invoke-webrequest?view=powershell-7.2
#>
function Invoke-DownloadGitHubRelease {
    param (
        [Parameter(Mandatory)]
        [string]$Owner,
        [Parameter(Mandatory)]
        [string]$Repository,
        [Parameter(Mandatory)]
        [string]$Asset,
        [Parameter()]
        [string]$Tag,
        [Parameter()]
        [string]$DownloadFolder
    )

    $tagSuffix = if ($Tag) { "tags/$Tag" } else { "latest" }
    $resolvedDownloadFolder = if ($DownloadFolder) { $DownloadFolder } else { Get-DownloadsFolder }

    $url = "https://api.github.com/repos/$Owner/$Repository/releases/$tagSuffix"
    $latestPowerShellRelease = Invoke-RestMethod -Uri $url -Method Get
    $latestPowerShellInstaller = $latestPowerShellRelease.assets | Where-Object Name -Like $Asset
    $downloadFileName = Join-Path -Path $resolvedDownloadFolder -ChildPath $latestPowerShellInstaller.name

    Invoke-WebRequest -Uri $latestPowerShellInstaller.browser_download_url -OutFile (New-Item -Path $downloadFileName -Force)

    return $downloadFileName
}
