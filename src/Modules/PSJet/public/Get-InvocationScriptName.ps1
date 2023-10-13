<#
    .SYNOPSIS
    Retrieves the script name without path and extension of the script that invoked the function.

    .DESCRIPTION
    The `Get-InvocationScriptName` function retrieves the script name (without path and extension) that invoked it.

    .PARAMETER None
    This function does not take any parameters.

    .OUTPUTS
    System.String
    The output of this function is a string that represents the name of the script (without path and extension) that invoked the function.

    .EXAMPLE
    Get-InvocationScriptName

    Description
    -----------
    This example returns the name of the script (without path and extension) that invoked the `Get-InvocationScriptName` function.

    .NOTES
    This function relies on the `Get-InvocationScript` function to obtain the full path of the invoking script. Ensure that `Get-InvocationScript` is available in the session or script where this function is used. 

    .LINK
    Get-InvocationScript
#>
function Get-InvocationScriptName {
    $invocationScriptPath = Get-InvocationScript
    $invocationScriptName = Get-Item $invocationScriptPath | Select-Object -ExpandProperty BaseName

    return $invocationScriptName
}
