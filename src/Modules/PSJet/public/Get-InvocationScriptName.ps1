<#
    .SYNOPSIS
    Retrieves the name of the script that invoked the function.

    .DESCRIPTION
    The `Get-InvocationScriptName` function retrieves the name of the script file that invoked it. This information can be useful for debugging purposes or for generating log entries that indicate which script is using the function.

    .PARAMETER None

    This function does not take any parameters.

    .OUTPUTS
    System.String

    The output of this function is a string that represents the name of the script that invoked the function.

    .EXAMPLE
    Get-InvocationScriptName

    This example returns the name of the script that invoked the `Get-InvocationScriptName` function.

    .NOTES
    This function relies on the `Get-PSCallStack` cmdlet, which retrieves information about the current call stack. The function filters the call stack information to include only entries that have a `ScriptName` property that is not `$null`, and then selects the last entry in the filtered list. This entry represents the script that invoked the function.

    .LINK
    Get-PSCallStack
#>
function Get-InvocationScriptName {
    $invocationScriptName = Get-PSCallStack | Where-Object ScriptName -ne $null | Select-Object -Last 1 | Select-Object ScriptName -ExpandProperty ScriptName

    return $invocationScriptName
}