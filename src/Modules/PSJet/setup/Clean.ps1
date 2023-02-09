$module = Get-Module -ListAvailable -Name PSJet

if ($module) {
    Remove-Module -Name PSJet -Force
}