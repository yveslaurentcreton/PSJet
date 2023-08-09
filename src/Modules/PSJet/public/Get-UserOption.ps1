<#
    .SYNOPSIS
    Prompts the user to select from provided options.

    .DESCRIPTION
    This function presents the user with a list of options to select from.
    If -MultiSelect is provided, the user can select multiple options.

    .PARAMETER Options
    A hashtable of options for the user to select from. Keys are the actual values, and values are the display names.

    .PARAMETER MultiSelect
    Allows the user to select multiple options.

    .EXAMPLE
    $fruits = @{
        A = 'Apple'
        B = 'Banana'
        C = 'Cherry'
    }
    Get-UserOption -Options $fruits

    This will prompt the user to select their favorite fruit from the provided options.
#>
function Get-UserOption {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [hashtable]$Options,

        [switch]$MultiSelect
    )

    $selectedValues = @()

    # Construct the option lookup with objects
    $optionLookup = @()
    $counter = 1
    foreach ($key in $Options.Keys) {
        $optionObject = New-Object PSObject -Property @{
            Index = $counter;
            Key   = $key;
            Value = $Options[$key];
        }
        $optionLookup += $optionObject
        $counter++
    }

    do {
        # Display the options
        $optionLookup | ForEach-Object {
            Write-Host "$($_.Index). $($_.Value)"
        }

        # Prompt the user for input
        $promptMessage = if ($MultiSelect) {
            "Select option(s) by number"
        } else {
            "Select option by number"
        }
        $inputValue = Read-Host -Prompt $promptMessage

        # Parse the input
        if ($MultiSelect) {
            $selectedNumbers = $inputValue -split ',' | ForEach-Object { [int]($_.Trim()) }
            foreach ($num in $selectedNumbers) {
                $selectedKey = ($optionLookup | Where-Object { $_.Index -eq $num }).Key
                if ($selectedKey) {
                    $selectedValues += $selectedKey
                }
            }
        } else {
            $inputValue = [int]$inputValue
            $selectedKey = ($optionLookup | Where-Object { $_.Index -eq $inputValue }).Key
            if ($selectedKey) {
                $selectedValues += $selectedKey
            }
        }

    } while ($selectedValues.Count -le 0)

    # Return the selected values
    if ($MultiSelect) {
        return $selectedValues
    } else {
        return $selectedValues[0]
    }
}
