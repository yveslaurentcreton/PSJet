<#
.SYNOPSIS
    Checks if the current user has administrative privileges.

.DESCRIPTION
    The Test-IsUserAdmin function checks if the current user is a member of the Administrators group. 
    It uses the .NET classes System.Security.Principal.WindowsIdentity and System.Security.Principal.WindowsPrincipal 
    to check the role of the current user. It returns True if the user is an Administrator, and False if they are not.

.EXAMPLE
    Test-IsUserAdmin
    
    Returns True if the user has administrative privileges, and False if they do not.

.INPUTS
    None.

.OUTPUTS
    Boolean. Returns True if the user has administrative privileges, and False if they do not.

.NOTES
    The function requires access to the .NET classes System.Security.Principal.WindowsIdentity and System.Security.Principal.WindowsPrincipal.
    If these classes are not available (e.g., if running on an older version of the .NET framework), the function will not work.
#>
function Test-IsUserAdmin {
    $windowsIdentity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
    $windowsPrincipal = New-Object System.Security.Principal.WindowsPrincipal($windowsIdentity)

    $isAdmin = $windowsPrincipal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)
    
    return $isAdmin
}
