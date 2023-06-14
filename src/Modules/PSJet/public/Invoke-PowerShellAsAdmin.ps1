<#
.SYNOPSIS
    Invokes a PowerShell script or a command as an administrator.

.DESCRIPTION
    This function is used to start a new PowerShell process with administrative privileges. 
    The function accepts either a PowerShell script file name or a command as a parameter, 
    but not both. The command or script is then executed in the new elevated PowerShell 
    session. The function first checks if the current user has administrator privileges and 
    if not, it throws an error.

.PARAMETER ScriptFileName
    The name of the PowerShell script file to be executed. This should be the full path to 
    the file. It is mutually exclusive with the Command parameter.

.PARAMETER Command
    The PowerShell command to be executed. It is a string that contains a valid PowerShell 
    command. It is mutually exclusive with the ScriptFileName parameter.

.EXAMPLE
    Invoke-PowerShellAsAdmin -ScriptFileName "C:\Path\to\your\script.ps1"
    
    Runs the specified PowerShell script as an administrator.

.EXAMPLE
    Invoke-PowerShellAsAdmin -Command "Get-Process"
    
    Runs the specified PowerShell command as an administrator.

.INPUTS
    String

.OUTPUTS
    None. This function does not return a value. The output will be whatever the invoked 
    script or command outputs.

.NOTES
    This function requires the user to have administrator privileges. If the user does not 
    have administrator privileges, the function will throw an error.
#>
function Invoke-PowerShellAsAdmin {
    param (
        [Parameter()]
        [string]$ScriptFileName,
        [Parameter()]
        [string]$Command
    )

    if (-Not (Test-IsElevatedAsAdmin))
    {
        Write-Error "Unable to create PowerShell session with administrator privileges. The current user does not have administrator privileges." -ErrorAction Stop
    }

    if ($ScriptFileName) {
        $scriptArgument = "-File `"$($ScriptFileName)`""
    }
    elseif ($Command) {
        $scriptArgument = "-Command `"$($Command)`""
    }
    else {
        $scriptArgument = ""
    }

    Write-Verbose "Starting a new PowerShell process with the following argument: $scriptArgument"
    Start-Process pwsh -Verb RunAs -ArgumentList "-ExecutionPolicy Bypass $scriptArgument"
}
