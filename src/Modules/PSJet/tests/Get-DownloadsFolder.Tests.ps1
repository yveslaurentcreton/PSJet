BeforeAll {
    Import-Module (Join-Path $PSScriptRoot "../PSJet.psm1")
}

Describe "Get-DownloadsFolder" {

    It "Returns the correct folder path on Windows" {
        if ($IsWindows -or $PSVersionTable.PSEdition -eq 'Desktop') {
            Get-DownloadsFolder | Should -Be "$($env:USERPROFILE)\Downloads"
        }
    }
    
    It "Returns the correct folder path on macOS" {
        if ($IsMacOS) {
            Get-DownloadsFolder | Should -Be "$($env:HOME)/Downloads"
        }
    }
    
    It "Returns the correct folder path on Linux" {
        if ($IsLinux) {
            Get-DownloadsFolder | Should -Be "$($env:HOME)/Downloads"
        }
    }
}