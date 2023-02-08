<#
    .SYNOPSIS
    This function starts a new process of PowerShell with administrator privileges.

    .DESCRIPTION
    The function takes in a parameter, Script, which is the path to the PowerShell script to be run with administrator privileges. The function sets the $scriptArgument variable based on whether the $Script parameter is provided or not. The function then starts a new process of PowerShell using the Start-Process cmdlet with the 'RunAs' verb and the argument list of "-ExecutionPolicy Bypass $scriptArgument".

    .PARAMETER Script
    The path to the PowerShell script to be run with administrator privileges.

    .EXAMPLE
    Invoke-PowerShellAsAdmin -Script "C:\Scripts\AdminScript.ps1"

    .NOTES
    The function uses the Start-Process cmdlet to start a new process of PowerShell with administrator privileges.

    .OUTPUTS
    None
#>
function Invoke-PowerShellAsAdmin {
    param (
        [Parameter()]
        [string]$Script
    )

    if ($Script) {
        $scriptArgument = "-File `"$($scriptFilename)`""
    }
    else {
        $scriptArgument = ""
    }

    Start-Process pwsh -Verb RunAs -ArgumentList "-ExecutionPolicy Bypass $scriptArgument"
}