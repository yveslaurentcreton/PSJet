<#
    .SYNOPSIS
    Checks if Chocolatey package manager is installed on the system.

    .DESCRIPTION
    This function checks if Chocolatey package manager is installed on the system by verifying the presence of the 'choco' command.

    .OUTPUTS
    [bool]
    Returns $true if Chocolatey is installed, and $false otherwise.

    .EXAMPLE
    PS> Test-IsChocolateyInstalled
    True

    .EXAMPLE
    PS> $isInstalled = Test-IsChocolateyInstalled
    PS> $isInstalled
    True
#>
function Test-IsChocolateyInstalled {
    
    $chocolateyInstalled = $null -ne (Get-Command -Name choco -ErrorAction SilentlyContinue)
    
    return $chocolateyInstalled
}