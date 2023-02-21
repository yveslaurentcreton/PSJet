<#
    .SYNOPSIS
    Registers a Visual Studio Extension Gallery with all installed instances of Visual Studio.

    .DESCRIPTION
    This function registers a Visual Studio Extension Gallery with all installed instances of Visual Studio. It creates a new GUID and adds a new registry key with the gallery information to the ExtensionManager\Repositories path in each Visual Studio registry. The gallery can be either a URL or a file path.

    .PARAMETER GalleryName
    The name of the extension gallery.

    .PARAMETER GalleryUrl
    The URL or file path of the extension gallery.

    .EXAMPLE
    Register-VisualStudioExtensionGallery -GalleryName "My Gallery" -GalleryUrl "http://example.com/gallery"

    Registers the extension gallery at http://example.com/gallery with all installed instances of Visual Studio under the name "My Gallery".

    .NOTES
    This function requires administrator privileges.
#>
function Register-VisualStudioExtensionGallery {
    param (
        [Parameter(Mandatory)]
        [string]$GalleryName,
        [Parameter(Mandatory)]
        [string]$GalleryUrl,
        [switch]$IsSharepointGallery = $false
    )

    $galleryUrl = $GalleryUrl.Replace("\", "/")
    if ([System.IO.File]::Exists($GalleryUrl)) {
        $encodedGalleryUrl = "file://{0}" -f [System.Uri]::EscapeUriString($galleryUrl)
    }
    else {
        $encodedGalleryUrl = [System.Uri]::EscapeUriString($galleryUrl)
    }

    $newGuid = New-Guid;
    $repositoryTemplatePath = "HKLM:\_TMPVS_[[VS_VERSION]]\Software\Microsoft\VisualStudio\[[VS_VERSION]]\ExtensionManager\Repositories"
    $visualStudioRegistries = Get-ChildItem "$env:LOCALAPPDATA/microsoft/visualstudio/*.0_*/privateregistry.bin"

    foreach ($visualStudioRegistry in $visualStudioRegistries) {
        $visualStudioInstance = $visualStudioRegistry.Directory
        $visualStudioVersion = $visualStudioInstance.BaseName;
        $repositoryPath = $repositoryTemplatePath.Replace("[[VS_VERSION]]", $visualStudioVersion)
        $galleryPath = Join-Path -Path $repositoryPath -ChildPath "{$($newGuid)}"
        $instancePath = "HKLM\_TMPVS_$($visualStudioVersion)"
        $protocol = if ($IsSharepointGallery) { "Sharepoint" } else { "Atom Feed" }

        # Load the visual studio hive
        [gc]::collect()
        & reg load "$($instancePath)" "$($visualStudioRegistry.FullName)" | Out-Null

        # Add the registry
        New-Item -Path $galleryPath -Force | Out-Null
        Set-ItemProperty -Path $galleryPath -Name "(Default)" -Value $encodedGalleryUrl
        Set-ItemProperty -Path $galleryPath -Name "Priority" -Value 100
        Set-ItemProperty -Path $galleryPath -Name "Protocol" -Value $protocol
        Set-ItemProperty -Path $galleryPath -Name "DisplayName" -Value $GalleryName

        # Unload the visual studio hive
        0 | Out-Null
        [gc]::collect()
        & reg unload "$($instancePath)" | Out-Null
    }
}
Register-VisualStudioExtensionGallery -GalleryName "yvcrelast2" -GalleryUrl "C:\Program Files\PowerShell\7\pwsh.exe"