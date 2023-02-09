<#
    .SYNOPSIS
    This function starts a new process of PowerShell with administrator privileges.

    .DESCRIPTION
    The function takes in two parameters, ScriptFileName and Command, either of which can be used to specify the script or command to run in the new process of PowerShell with administrator privileges. If both parameters are not provided, the function will start a new process of PowerShell with no arguments. The function sets the $scriptArgument variable based on whether the $ScriptFileName or $Command parameter is provided or not. The function then starts a new process of PowerShell using the Start-Process cmdlet with the 'RunAs' verb and the argument list of "-ExecutionPolicy Bypass $scriptArgument".

    .PARAMETER ScriptFileName
    The path to the PowerShell script to be run with administrator privileges.

    .PARAMETER Command
    The PowerShell command to be run with administrator privileges.

    .EXAMPLE
    Invoke-PowerShellAsAdmin -ScriptFileName "C:\Scripts\AdminScript.ps1"
    Invoke-PowerShellAsAdmin -Command "Get-Service"

    .NOTES
    The function uses the Start-Process cmdlet to start a new process of PowerShell with administrator privileges.

    .OUTPUTS
    None
#>
function Invoke-PowerShellAsAdmin {
    param (
        [Parameter()]
        [string]$ScriptFileName,
        [Parameter()]
        [string]$Command
    )

    if ($Script) {
        $scriptArgument = "-File `"$($ScriptFileName)`""
    }
    elseif ($Command) {
        $scriptArgument = "-Command `"$($Command)`""
    }
    else {
        $scriptArgument = ""
    }

    Start-Process pwsh -Verb RunAs -ArgumentList "-ExecutionPolicy Bypass $scriptArgument"
}