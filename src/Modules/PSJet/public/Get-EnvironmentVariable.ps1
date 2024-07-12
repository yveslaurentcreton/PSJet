<#
    .SYNOPSIS
    Retrieves the value of an environment variable.

    .DESCRIPTION
    The Get-EnvironmentVariable function retrieves the value of a specified environment variable from the
    machine, user, or process scope.

    .PARAMETER Name
    The name of the environment variable to retrieve.

    .PARAMETER Scope
    The scope from which to retrieve the environment variable. Valid values are 'Machine', 'User', and 'Process'.

    .EXAMPLE
    Get-EnvironmentVariable -Name "Path" -Scope "Machine"

    .NOTES
    This function only retrieves the value of the specified environment variable without making any changes to the system.
#>
function Get-EnvironmentVariable {
  param (
      [Parameter(Mandatory)]
      [string]$Name,

      [Parameter(Mandatory)]
      [ValidateSet("Machine", "User", "Process")]
      [string]$Scope
  )

  try {
      # Retrieve the value of the environment variable based on the specified scope
      $value = [System.Environment]::GetEnvironmentVariable($Name, [System.EnvironmentVariableTarget]::$Scope)

      if ($null -eq $value) {
          Write-Warning "Environment variable '$Name' not found in the '$Scope' scope."
      } else {
          Write-Output $value
      }
  } catch {
      Write-Error "Failed to retrieve the environment variable '$Name': $_"
  }
}
