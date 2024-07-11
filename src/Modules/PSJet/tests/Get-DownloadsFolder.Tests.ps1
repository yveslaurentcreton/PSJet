BeforeAll {
    Import-Module (Join-Path $PSScriptRoot "../PSJet.psm1")

    function Get-MacOSVersion {
        # Get macOS version using sw_vers command
        $version = (sw_vers -productVersion).Split('.')
        return [PSCustomObject]@{
            Major = [int]$version[0]
            Minor = [int]$version[1]
            Patch = if ($version.Count -gt 2) { [int]$version[2] } else { 0 }
        }
    }
}

Describe "Get-DownloadsFolder" {
    It "Returns the correct folder path on Windows" {
        if ($IsWindows -or $PSVersionTable.PSEdition -eq 'Desktop') {
            Get-DownloadsFolder | Should -Be "$($env:USERPROFILE)\Downloads"
        }
    }
    
    It "Returns the correct folder path on macOS" {
        if ($IsMacOS) {
            $macOSVersion = Get-MacOSVersion
            if ($macOSVersion.Major -ge 14) {
                $expectedPath = "$($env:HOME)/Documents/Downloads"
            } else {
                $expectedPath = "$($env:HOME)/Downloads"
            }
            
            Get-DownloadsFolder | Should -Be $expectedPath
        }
    }
    
    It "Returns the correct folder path on Linux" {
        if ($IsLinux) {
            Get-DownloadsFolder | Should -Be "$($env:HOME)/Downloads"
        }
    }
}
