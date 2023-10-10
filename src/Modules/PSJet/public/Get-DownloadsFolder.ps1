<#
.SYNOPSIS
    Gets the path of the current user's Downloads folder.

.DESCRIPTION
    The Get-DownloadsFolder function retrieves the path 
    to the Downloads folder for the current user in Windows, macOS, and Linux environments.

.EXAMPLE
    Get-DownloadsFolder
    
    Retrieves the path of the Downloads folder and outputs it to the console.

.OUTPUTS
    String
    The function outputs a string representing the full path to the Downloads folder.
#>
function Get-DownloadsFolder {
    [CmdletBinding()]
    param()

    try {
        if ($PSVersionTable.PSEdition -eq 'Desktop') {
            # Using Shell.Application to get Downloads folder path
            $shell = New-Object -ComObject Shell.Application
            $downloadsFolder = $shell.NameSpace('shell:Downloads').Self.Path
        }
        elseif ($IsWindows) {
            # Using Shell.Application to get Downloads folder path
            $shell = New-Object -ComObject Shell.Application
            $downloadsFolder = $shell.NameSpace('shell:Downloads').Self.Path
        }
        elseif ($IsMacOS) {
            $downloadsFolder = [System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::Personal) + '/Downloads'
        }
        elseif ($IsLinux) {
            $downloadsFolder = "$HOME/Downloads"
        }
        else {
            throw "Unsupported platform"
        }

        if (-not [string]::IsNullOrWhiteSpace($downloadsFolder)) {
            return $downloadsFolder
        }
        else {
            $errorMessage = "Failed to retrieve the Downloads folder path: Result was null or white space."
            Write-Error -Message $errorMessage -Category InvalidOperation
        }
    }
    catch {
        $errorMessage = "An unexpected error occurred: $_"
        Write-Error -Message $errorMessage -Category InvalidOperation
    }
}
