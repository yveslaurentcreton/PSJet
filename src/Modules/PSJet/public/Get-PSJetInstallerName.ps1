
<#
    .SYNOPSIS
        Retrieves the name of the invoking PSJet installer script.

    .DESCRIPTION
        The `Get-PSJetInstallerName` function fetches the name of the PowerShell script that invoked the function. 
        It relies on determining the script name dynamically during runtime. This can be useful for logging, debugging, 
        or any functionalities that require the knowledge of the invoking script's name.
        
        Note: The function assumes that it's being called within a script and might not behave as expected when used 
        in the console or other non-script contexts.

    .EXAMPLE
        $installerName = Get-PSJetInstallerName

        Description
        -----------
        Retrieves the name of the invoking installer script and stores it in the `$installerName` variable.

    .NOTES
        - Ensure that the function is being utilized within a script to guarantee accurate retrieval of the invoking script's name.
        - If utilized in non-script contexts, modifications or additional handling may be required.
        - The function does not validate the existence or accessibility of the retrieved script name.

    .OUTPUTS
        String
        The name of the invoking PSJet Installer PowerShell script. 
#>
function Get-PSJetInstallerName {
    $installerScript = Get-InvocationScriptName
    $installerName = Get-Item $installerScript | Select-Object Name -ExpandProperty Name
    
    return $installerName
}