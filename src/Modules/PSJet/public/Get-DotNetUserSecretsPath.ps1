<#
.SYNOPSIS
    Retrieves the path to the user secrets file based on a given .csproj file.

.DESCRIPTION
    This script extracts the UserSecretsId from the specified .csproj file and 
    constructs the path to the corresponding user secrets file. It supports 
    Windows, Linux, and macOS platforms. The script is designed to handle cases 
    where multiple PropertyGroup elements are present in the .csproj file and 
    extracts the first non-null UserSecretsId.

.PARAMETER CsprojPath
    The path to the .csproj file from which to extract the UserSecretsId.

.OUTPUTS
    String. The path to the user secrets file.
#>
function Get-DotNetUserSecretsPath {
    param (
        [Parameter(Mandatory=$true)]
        [string]$CsprojPath
    )

    if (-not (Test-Path $CsprojPath)) {
        throw "csproj file not found at path: $CsprojPath"
    }

    # Load and parse the .csproj file
    [xml]$csprojContent = Get-Content $CsprojPath

    # Extract the first non-null UserSecretsId
    $userSecretsId = $csprojContent.Project.PropertyGroup.UserSecretsId |
                     Where-Object { $_ -ne $null } |
                     Select-Object -First 1

    if (-not $userSecretsId) {
        throw "UserSecretsId not found in the csproj file."
    }

    # Trim the UserSecretsId to remove any accidental whitespace
    $userSecretsId = $userSecretsId.Trim()

    # Determine the path for the secrets file based on the platform
    $secretsPath = $null
    if ($IsWindows) {
        $secretsPath = Join-Path $env:APPDATA "Microsoft\UserSecrets\$userSecretsId\secrets.json"
    } elseif ($IsLinux -or $IsMacOS) {
        $secretsPath = Join-Path $HOME ".microsoft/usersecrets/$userSecretsId/secrets.json"
    } else {
        throw "Unsupported operating system."
    }

    return $secretsPath
}
