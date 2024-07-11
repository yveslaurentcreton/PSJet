# Install NuGet package provider and PowerShellGet module
powershell -NoProfile -Command {
  Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
  Install-Module PowerShellGet -Force
}

# Install PSJet module
powershell -NoProfile -Command {
  Install-Module -Name PSJet -AllowPrerelease -Force
}

# Install WinGet
powershell -NoProfile -Command {
  $currentProgressPreference = $ProgressPreference
  $ProgressPreference = 'SilentlyContinue'
  Install-WinGet
  $ProgressPreference = $currentProgressPreference
}

# Install Windows Terminal and PowerShell via WinGet
powershell -NoProfile -Command {
  winget install --id "9N0DX20HK701" --exact --source "msstore" --accept-source-agreements --accept-package-agreements
  winget install --id "Microsoft.PowerShell" --exact --source "winget" --override "/quiet REGISTER_MANIFEST=1 ENABLE_PSREMOTING=1 ADD_EXPLORER_CONTEXT_MENU_OPENPOWERSHELL=1 ADD_FILE_CONTEXT_MENU_RUNPOWERSHELL=1"
}

# Refresh the PATH environment variables
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") 

# Install PSJet in PowerShell
pwsh -NoProfile -Command {
  Install-Module -Name PSJet -AllowPrerelease -Force
}

Write-Output "Installation complete. You can now use Windows Terminal with PowerShell with PSJet"
