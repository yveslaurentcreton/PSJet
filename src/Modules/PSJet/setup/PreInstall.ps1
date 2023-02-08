# Pre-install script to check if the MSI PowerShell module is installed

# Check if the MSI PowerShell module is installed
$module = Get-Module -Name MSI -ListAvailable

# If the module is not installed, install it
if ($module -eq $null) {
    Install-Module -Name MSI -Force
}