<#
    .SYNOPSIS
    Updates the environment variables for the current PowerShell session.

    .DESCRIPTION
    The Update-PSEnvironmentVariables function updates the environment variables, including the PATH variable,
    for the current PowerShell session. This ensures that any newly installed software is immediately available
    without the need to restart the console.

    .EXAMPLE
    Update-PSEnvironmentVariables

    .NOTES
    This function only updates the environment variables within the current session and does not make permanent changes.
#>
function Update-PSEnvironmentVariables {
    try {
        # Retrieve the current system and user PATH environment variables using Get-EnvironmentVariable function
        $systemPath = Get-EnvironmentVariable -Name "Path" -Scope "Machine"
        $userPath = Get-EnvironmentVariable -Name "Path" -Scope "User"
        
        # Combine the system and user PATH variables
        $newPath = "$systemPath;$userPath"
        Set-Item -Path Env:Path -Value $newPath

        # Retrieve all environment variables for the current session from the 'Machine' scope
        $machineVariables = Get-EnvironmentVariables -Scope "Machine"
        foreach ($variable in $machineVariables.Keys) {
            Set-Item -Path "Env:$variable" -Value $machineVariables[$variable]
        }

        # Retrieve all environment variables for the current session from the 'User' scope
        $userVariables = Get-EnvironmentVariables -Scope "User"
        foreach ($variable in $userVariables.Keys) {
            Set-Item -Path "Env:$variable" -Value $userVariables[$variable]
        }

        Write-Output "PowerShell environment variables updated successfully."
    } catch {
        Write-Error "Failed to update PowerShell environment variables: $_"
    }
}
