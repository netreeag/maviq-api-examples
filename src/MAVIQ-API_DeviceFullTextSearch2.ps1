<#
.SYNOPSIS
Search for all terms that start with 'win' in specific fields and return the first 100 devices that match that search
#>
[CmdletBinding()]
param()

<# Authentication #>

# Authenticate / Get access token
. (Join-Path $PSScriptRoot "MAVIQ-API_Authenticate.ps1")

<# Request #>

# Define the request URL
$requestUrl = "$($maviqApiRootUrl)$($maviqTenantId)/device/search"

# Define the search parameters
$query = [PSCustomObject]@{
    search = "win*" # This will search for all terms that start with 'win'
    searchFields = "deviceName,osName" # The fields to include in the search for the search term(s)
    count = $true
    skip = 0
    top = 100
    select = "deviceName,osName"
    orderby = "deviceName asc"
}

# Execute the request
$searchResult = Invoke-RestMethod -Method Post -Uri $requestUrl -Authentication Bearer -Token $accessToken -Body ($query | ConvertTo-Json -Depth 100) -ContentType "application/json" -ErrorAction Stop

# Output results
Write-Verbose "Total number of search results: $($searchResult."@odata.count"). Showing $($searchResult.value.Count) search results."
$searchResult.value
