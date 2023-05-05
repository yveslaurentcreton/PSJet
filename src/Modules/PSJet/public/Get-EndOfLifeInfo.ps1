<#
.SYNOPSIS
   Retrieves end-of-life information for a specified product from the endoflife.date API.

.DESCRIPTION
   This function queries the endoflife.date API to obtain the end-of-life information for a specified product.
   It returns a custom object containing the relevant details.

.PARAMETER Name
   The display name to be used as a prefix in the output object's "Name" property.

.PARAMETER Product
   The product identifier to query from the endoflife.date API.

.EXAMPLE
   Get-EndOfLifeInfo -Name ".NET" -Product "dotnet"

   Retrieves the end-of-life information for the .NET product from the endoflife.date API.
#>
function Get-EndOfLifeInfo {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Name,

        [Parameter(Mandatory=$true)]
        [string]$Product
    )

    try {
        $url = "https://endoflife.date/api/$Product"
        $response = Invoke-WebRequest -Uri $url -UseBasicParsing

        if ($response.StatusCode -eq 200) {
            $inputItems = $response | ConvertFrom-Json
            $outputItems = @()

            foreach ($inputItem in $inputItems) {
                $itemName = "$($Name) "
                $itemName += if ($inputItem.releaseLabel) {
                    $inputItem.releaseLabel -replace '__RELEASE_CYCLE__', $inputItem.cycle
                } else {
                    $inputItem.cycle
                }
                $endOfLife = if ($inputItem.eol) { [datetime]::ParseExact($inputItem.eol, 'yyyy-MM-dd', $null) } else { [datetime]::MaxValue }
                $latestReleaseDate = if ($inputItem.latestReleaseDate) { [datetime]::ParseExact($inputItem.latestReleaseDate, 'yyyy-MM-dd', $null) } else { $null }
                $releaseDate = if ($inputItem.releaseDate) { [datetime]::ParseExact($inputItem.releaseDate, 'yyyy-MM-dd', $null) } else { $null }

                $outputItems += [PSCustomObject]@{
                    "Name" = $itemName
                    "Cycle" = $inputItem.cycle
                    "Discontinued" = $inputItem.discontinued
                    "EndOfLife" = $endOfLife
                    "Latest" = $inputItem.latest
                    "LatestReleaseDate" = $latestReleaseDate
                    "Link" = $inputItem.link
                    "LTS" = $inputItem.lts
                    "ReleaseDate" = $releaseDate
                    "Support" = $inputItem.support
                }
            }

            return $outputItems
        } else {
            Write-Error "Error: Unable to retrieve information for product '$Product'."
            return
        }
    } catch {
        Write-Error "Error: An exception occurred while querying the endoflife.date API."
    }
}
