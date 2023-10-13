<#
    .SYNOPSIS
    Retrieves the directory of the script that invoked the function.

    .DESCRIPTION
    The `Get-InvocationDirectory` function retrieves the directory path of the script file that invoked it. This information can be useful for debugging purposes, generating log entries, or determining relative paths based on the invoking script's location.

    .PARAMETER None
    This function does not take any parameters.

    .OUTPUTS
    System.String
    The output of this function is a string that represents the directory path of the script that invoked the function.

    .EXAMPLE
    Get-InvocationDirectory

    Description
    -----------
    This example returns the directory path of the script that invoked the `Get-InvocationDirectory` function.

    .NOTES
    This function relies on the `Get-InvocationScript` function to obtain the name of the invoking script. Ensure that `Get-InvocationScript` is available in the session or script where this function is used. 

    .LINK
    Get-InvocationScript
#>
function Get-InvocationDirectory {
    $invocationScriptName = Get-InvocationScript
    $invocationDirectory = Get-Item $invocationScriptName | Select-Object DirectoryName -ExpandProperty DirectoryName

    return $invocationDirectory
}
