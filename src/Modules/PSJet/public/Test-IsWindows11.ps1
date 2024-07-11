<#
.SYNOPSIS
   Checks if the current system is running Windows 11.

.DESCRIPTION
   This function uses the automatic variable $IsWindows to check if the 
   system is running Windows. If it is, the function then uses the Get-WmiObject 
   cmdlet to get the operating system information and checks if the system is 
   running Windows 11.

.EXAMPLE
   Test-IsWindows11
#>
function Test-IsWindows11 {
    if (!$IsWindows) {
        return $false
    }
    
    $OS = Get-WmiObject -Class Win32_OperatingSystem
    return $OS.Caption -like "*Windows 11*"
}