<#
    .SYNOPSIS
    Checks if Windows Package Manager (WinGet) is installed on the system.

    .DESCRIPTION
    The Test-IsWinGetInstalled function determines whether the Windows Package Manager (WinGet) is installed on the system. It does this by checking if the "winget" command is available.

    .PARAMETER None
    This function does not accept any parameters.

    .OUTPUTS
    [System.Boolean]
    Returns $true if WinGet is installed, otherwise returns $false.

    .EXAMPLE
    PS> Test-IsWinGetInstalled
    True
#>
function Test-IsWinGetInstalled {
    
    $wingetInstalled = $null -ne (Get-Command -Name winget -ErrorAction SilentlyContinue)
    
    return $wingetInstalled
}