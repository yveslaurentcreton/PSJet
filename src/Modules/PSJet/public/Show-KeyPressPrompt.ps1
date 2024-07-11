<#
    .SYNOPSIS
    Displays a message to the user and waits for a key press.

    .DESCRIPTION
    The Show-KeyPressPrompt function displays a message (default or custom) 
    to the console using Write-Information and waits for the user to press any key.

    .PARAMETER Message
    A custom message that will be displayed to the user. 
    If not provided, defaults to 'Press any key to continue...'.

    .EXAMPLE
    Show-KeyPressPrompt
    
    Displays the default message 'Press any key to continue...' and waits for a key press.

    .EXAMPLE
    Show-KeyPressPrompt -Message 'Press a key to proceed...'
    
    Displays the custom message 'Press a key to proceed...' and waits for a key press.
#>
function Show-KeyPressPrompt {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$false)]
        [string]$Message = 'Press any key to continue...'
    )

    Write-Information $Message -InformationAction Continue
    $null = [Console]::ReadKey()
}
