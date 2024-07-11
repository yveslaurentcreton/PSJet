<#
    .SYNOPSIS
    Determines if the current user has administrative privileges.

    .DESCRIPTION
    The Test-IsElevatedAsAdmin function determines if the current user has administrative privileges by using the .NET Framework to check the Windows built-in role of the current Windows identity. The function returns a Boolean value indicating whether the current user is a member of the 'Administrator' role.

    .EXAMPLE
    Test-IsElevatedAsAdmin

    This example returns $True if the current user has administrative privileges, or $False if the current user does not have administrative privileges.

    .OUTPUTS
    System.Boolean. $True if the current user has administrative privileges, or $False if the current user does not have administrative privileges.

    .NOTES
    None.

    .FUNCTIONALITY
    Checking the current user's Windows built-in role.
#>
function Test-IsElevatedAsAdmin {
    $isElevatedAsAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')

    return $isElevatedAsAdmin
}