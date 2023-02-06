Get-ChildItem -Path $PSScriptRoot\public\*.ps1, $PSScriptRoot\private\*.ps1 -Exclude *.tests.ps1, *profile.ps1 -ErrorAction SilentlyContinue | ForEach-Object {
    . $_.FullName
    Export-ModuleMember -Function $_.BaseName
}