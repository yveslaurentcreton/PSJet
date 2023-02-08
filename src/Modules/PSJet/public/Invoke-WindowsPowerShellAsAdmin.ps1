<#
    .SYNOPSIS
    This function starts a new process of Windows PowerShell with administrator privileges.

    .DESCRIPTION
    The function takes in a mandatory parameter, $Script, which is the path to the Windows PowerShell script to be run with administrator privileges. The function sets the $scriptArgument variable based on whether the $Script parameter is provided or not. The function then starts a new process of Windows PowerShell using the Start-Process cmdlet with the 'RunAs' verb and the argument list of "-ExecutionPolicy Bypass $scriptArgument".

    .PARAMETER Script
    The path to the Windows PowerShell script to be run with administrator privileges.

    .EXAMPLE
    Invoke-WindowsPowerShellAsAdmin -Script "C:\Scripts\AdminScript.ps1"

    .NOTES
    The function uses the Start-Process cmdlet to start a new process of Windows PowerShell with administrator privileges.

    .OUTPUTS
    None
#>
function Invoke-WindowsPowerShellAsAdmin {
    param (
        [Parameter(Mandatory)]
        [string]$Script
    )

    if ($Script) {
        $scriptArgument = "-File `"$($scriptFilename)`""
    }
    else {
        $scriptArgument = ""
    }

    Start-Process powershell -Verb RunAs -ArgumentList "-ExecutionPolicy Bypass $scriptArgument"
}