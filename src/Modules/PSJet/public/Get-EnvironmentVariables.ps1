<#
    .SYNOPSIS
    Retrieves all environment variables from the specified scope.

    .DESCRIPTION
    The Get-EnvironmentVariables function retrieves all environment variables from the specified scope (Machine, User, or Process).
    This function returns a dictionary of environment variable names and their values.

    .PARAMETER Scope
    The scope from which to retrieve the environment variables. Valid values are 'Machine', 'User', and 'Process'.

    .EXAMPLE
    Get-EnvironmentVariables -Scope "Machine"

    .NOTES
    This function only retrieves the environment variables without making any changes to the system.

    .LINK
    https://docs.microsoft.com/en-us/powershell/scripting/developer/cmdlet/writing-a-windows-powershell-function
#>
function Get-EnvironmentVariables {
  param (
      [Parameter(Mandatory)]
      [ValidateSet("Machine", "User", "Process")]
      [string]$Scope
  )

  try {
      # Retrieve all environment variables for the specified scope
      $envVars = [System.Environment]::GetEnvironmentVariables([System.EnvironmentVariableTarget]::$Scope)
      return $envVars
  } catch {
      Write-Error "Failed to retrieve environment variables for scope '$Scope': $_"
  }
}
