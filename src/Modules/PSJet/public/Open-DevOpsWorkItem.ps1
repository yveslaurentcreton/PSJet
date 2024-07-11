<#
    .SYNOPSIS
    Opens an Azure DevOps work item in a web browser.

    .DESCRIPTION
    This script, if provided with a work item number, will directly open the work item in the specified or default web browser.
    If no work item number is provided, it prompts the user for one using the Get-UserInput function.

    .PARAMETER DevOpsURL
    The complete URL for the Azure DevOps instance, including the organization and project.

    .PARAMETER Organization
    The organization name in Azure DevOps. If DevOpsURL is not provided, this becomes mandatory.

    .PARAMETER Project
    An optional parameter for the Azure DevOps project within the specified organization.

    .PARAMETER WorkItemNumber
    An optional parameter for the Azure DevOps work item number. If not provided, the user will be prompted for it.

    .PARAMETER BrowserPath
    The path to the browser executable. If provided, this browser will be used instead of the default browser.

    .PARAMETER BrowserArguments
    Additional arguments to pass to the browser when opening the URL.

    .EXAMPLE
    Open-DevOpsWorkItem -Organization "MyOrganization"

    This will prompt the user for a work item number and then open the corresponding work item for the specified organization.

    .EXAMPLE
    Open-DevOpsWorkItem -DevOpsURL "https://dev.azure.com/MyOrganization/MyProject" -WorkItemNumber 12345

    This will open work item number 12345 for the specified organization and project without any user prompts.

    .EXAMPLE
    Open-DevOpsWorkItem -Organization "MyOrganization" -BrowserPath "C:\Program Files\Google\Chrome\Application\chrome.exe" -BrowserArguments "--profile-directory=`"MyBrowserProfile`""

    This will prompt the user for a work item number and then open the corresponding work item in Google Chrome with the "MyBrowserProfile" profile.
#>
function Open-DevOpsWorkItem {
    [CmdletBinding(DefaultParameterSetName='ByURL')]
    param (
        [Parameter(Mandatory=$true, ParameterSetName='ByURL')]
        [string]$DevOpsURL,

        [Parameter(Mandatory=$true, ParameterSetName='ByOrg')]
        [string]$Organization,

        [Parameter(Mandatory=$false)]
        [string]$Project,

        [Parameter(Mandatory=$false)]
        [int]$WorkItemNumber,

        [Parameter(Mandatory=$false)]
        [string]$BrowserPath,

        [Parameter(Mandatory=$false)]
        [string]$BrowserArguments
    )

    # If no work item number provided, get it from the user
    if (-not $WorkItemNumber) {
        $WorkItemNumber = Get-UserInput -Message "Please provide the Azure DevOps work item number"
    }

    # Construct the full URL to the work item based on provided parameters
    if (-not $DevOpsURL) {
        $DevOpsURL = "https://dev.azure.com/$Organization"
        if ($Project) {
            $DevOpsURL += "/$Project"
        }
    }
    $workItemURL = "$DevOpsURL/_workitems/edit/$WorkItemNumber"

    # Open the URL in the specified browser or default browser
    if ($BrowserPath) {
        $arguments = "$BrowserArguments $workItemURL"
        Start-Process -FilePath $BrowserPath -ArgumentList $arguments
    } else {
        Start-Process $workItemURL
    }
}
