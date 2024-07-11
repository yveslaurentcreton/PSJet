<#
    .SYNOPSIS
    Elevates the PowerShell session to run with administrator privileges.

    .DESCRIPTION
    This function determines whether it's running in Windows PowerShell or PowerShell Core and attempts to elevate the session to run with administrator privileges by calling a corresponding function. Windows PowerShell and PowerShell Core are distinguished by the PSEdition property of the $PSVersionTable automatic variable.

    .EXAMPLE
    Invoke-ElevateAsAdmin

    Executes the function to elevate the PowerShell session to run with administrator privileges.

    .NOTES
    Ensure that 'Invoke-ElevateWindowsPowerShellAsAdmin' and 'Invoke-ElevatePowerShellAsAdmin' functions are available in the session/script before calling this function. This function does not perform elevation by itself but instead calls one of the aforementioned functions to perform the elevation.
#>
function Invoke-ElevateAsAdmin {

    # Determine if running Windows PowerShell or PowerShell Core
    if ($PSVersionTable.PSEdition -eq 'Desktop')
    {
        # This is Windows PowerShell
        Invoke-ElevateWindowsPowerShellAsAdmin
    }
    else
    {
        # This is PowerShell Core
        Invoke-ElevatePowerShellAsAdmin
    }
}
