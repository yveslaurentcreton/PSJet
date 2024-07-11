<#
    .SYNOPSIS
    Prompts the user for input until a non-empty value is provided.

    .DESCRIPTION
    This function will repeatedly prompt the user for input using the provided message until a non-empty value is provided. 
    If the -AllowEmpty switch is used, the function will accept an empty input as valid.

    .PARAMETER Message
    The message to display to the user when prompting for input.

    .PARAMETER AllowEmpty
    Allows the input to be empty.

    .EXAMPLE
    Get-UserInput -Message "Please provide your name:"

    This will repeatedly prompt the user with the message "Please provide your name:" until a non-empty value is provided.

    .EXAMPLE
    Get-UserInput -Message "Please provide your name (optional):" -AllowEmpty

    This will prompt the user once with the message "Please provide your name (optional):" and will accept an empty input.
#>
function Get-UserInput {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$Message,
        [switch]$AllowEmpty
    )

    do {
        $inputValue = Read-Host -Prompt $Message
    } while (-not $AllowEmpty -and ($null -eq $inputValue -or '' -eq $inputValue))

    return $inputValue
}
