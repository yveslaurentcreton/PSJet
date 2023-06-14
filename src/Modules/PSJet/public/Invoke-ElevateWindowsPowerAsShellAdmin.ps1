<#
.SYNOPSIS
    Checks the current user's permissions and if they are not an administrator, attempts to elevate the Windows PowerShell session to run with administrator privileges.

.DESCRIPTION
    The Invoke-ElevateWindowsPowerShellAsAdmin function checks whether the current user has administrative privileges. If they do not, 
    the function attempts to elevate the Windows PowerShell session to run with administrator privileges by invoking the PowerShell script with admin rights.
    This operation requires at least Windows Vista. If the user already has administrative privileges, a message is displayed and no action is taken.

.INPUTS
    None.

.OUTPUTS
    None. This function does not return a value.

.EXAMPLE
    Invoke-ElevateWindowsPowerShellAsAdmin
    
    Attempts to elevate the current Windows PowerShell session to run with administrator privileges.

.NOTES
    This function requires at least Windows Vista to elevate the session. If the OS is older than Windows Vista, 
    the function will display a message and will not attempt to elevate the session.
#>
function Invoke-ElevateWindowsPowerShellAsAdmin {

    if (-Not (Test-IsElevatedAsAdmin))
    {
        Write-Host 'Elevating Windows PowerShell session to run with administrator privileges...'
        
        if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000)
        {
            $scriptFilename = Get-InvocationScriptName
            Invoke-WindowsPowerShellAsAdmin -Script $scriptFilename
            Exit
        }
        else
        {
            Write-Error 'Elevation requires Windows Vista or later.' -ErrorAction Stop
        }
    }
    else
    {
        Write-Warning 'The current user already has administrator privileges.'
    }
}
