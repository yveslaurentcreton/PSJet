<#
.SYNOPSIS
This function invokes a PowerShell script with administrator privileges.

.DESCRIPTION
The function checks if the current user has administrator privileges. If the user does not have administrator privileges, the function starts a new process of PowerShell with administrator privileges. This new process will run the same script that was invoked originally. The function exits once the new process has been started.

.PARAMETER None

.EXAMPLE
Invoke-ElevateAsAdminPowerShell

.NOTES
The function uses the BuildNumber property of the Win32_OperatingSystem CIM class to determine if the operating system is Windows Vista or later. The function uses the Start-Process cmdlet to start a new process of PowerShell with administrator privileges.

.OUTPUTS
None
#>
function Invoke-ElevateAsAdminPowerShell {

    $scriptFilename = Get-InvocationScriptName

    if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator'))
    {
        if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000)
        {
            Start-Process pwsh -Verb RunAs -ArgumentList "-ExecutionPolicy Bypass -File `"$($scriptFilename)`""
            Exit
        }
    }
}