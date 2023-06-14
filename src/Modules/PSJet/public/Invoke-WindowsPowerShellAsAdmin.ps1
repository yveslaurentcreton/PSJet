<#
.SYNOPSIS
    Invokes a Windows PowerShell script as an administrator.

.DESCRIPTION
    The Invoke-WindowsPowerShellAsAdmin function starts a new Windows PowerShell process with administrative privileges 
    and executes the provided script in the new elevated session. If the user does not have administrative privileges, 
    the function throws an error.

.PARAMETER ScriptFileName
    The name of the PowerShell script file to be executed. This should be the full path to the file.

.EXAMPLE
    Invoke-WindowsPowerShellAsAdmin -Script "C:\Path\to\your\script.ps1"
    
    Runs the specified Windows PowerShell script as an administrator.

.INPUTS
    String

.OUTPUTS
    None. This function does not return a value. The output will be whatever the invoked script outputs.

.NOTES
    This function requires the user to have administrator privileges. If the user does not have administrator privileges, 
    the function will throw an error.
#>
function Invoke-WindowsPowerShellAsAdmin {
    param (
        [Parameter()]
        [string]$ScriptFileName
    )

    if (-Not (Test-IsElevatedAsAdmin))
    {
        Write-Error "Unable to create Windows PowerShell session with administrator privileges. The current user does not have administrator privileges." -ErrorAction Stop
    }

    if ($ScriptFileName) {
        $scriptArgument = "-File `"$($ScriptFileName)`""
    }
    else {
        $scriptArgument = ""
    }

    Write-Verbose "Starting a new Windows PowerShell process with the following argument: $scriptArgument"
    Start-Process powershell -Verb RunAs -ArgumentList "-ExecutionPolicy Bypass $scriptArgument"
}