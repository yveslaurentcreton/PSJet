<#
    .SYNOPSIS
    Installs the specified GitHub release asset

    .DESCRIPTION
    The Install-GitHubRelease function downloads and installs the specified GitHub release asset.
    The function uses Invoke-DownloadGitHubRelease function to download the asset and Install-MSIProduct function to install it.

    .PARAMETER Owner
    The name of the GitHub user or organization that owns the repository.

    .PARAMETER Repository
    The name of the repository that contains the release asset.

    .PARAMETER Asset
    The name of the asset to be downloaded and installed.

    .PARAMETER Tag
    The tag or version of the release that contains the asset.
    If not specified, the latest release will be used.

    .EXAMPLE
    Install-GitHubRelease -Owner "Microsoft" -Repository "PowerShell" -Asset "Microsoft.PowerShell.*.msi"

    .EXAMPLE
    Install-GitHubRelease -Owner "Microsoft" -Repository "PowerShell" -Asset "Microsoft.PowerShell.7.0.0-rc.1.msi" -Tag "v7.0.0-rc.1"

    .NOTES
    This function requires the Invoke-DownloadGitHubRelease and Install-MSIProduct functions to be available in the current session.
#>
function Install-GitHubRelease {
    param (
        [Parameter(Mandatory)]
        [string]$Owner,
        [Parameter(Mandatory)]
        [string]$Repository,
        [Parameter(Mandatory)]
        [string]$Asset,
        [Parameter()]
        [string]$Tag
    )

    $downloadFileName = Invoke-DownloadGitHubRelease -Owner $Owner -Repository $Repository -Asset $Asset -Tag $Tag
    Install-MSIProduct $downloadFileName
}