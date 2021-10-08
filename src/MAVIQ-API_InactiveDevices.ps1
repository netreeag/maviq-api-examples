<#
.SYNOPSIS
Get a list of the first 100 devices that have not been active in the last 10 days.
#>
[CmdletBinding()]
param()

<# Authentication #>

# Authenticate / Get access token
. (Join-Path $PSScriptRoot "MAVIQ-API_Authenticate.ps1")

<# Request #>

# Define the request URL
$requestUrl = "$($maviqApiRootUrl)$($maviqTenantId)/device/search"

# Get the date from 10 days ago
$lastActivityLimit = [DateTime]::UtcNow.AddDays(-10).Date

# Define the search parameters
$query = [PSCustomObject]@{
    filter = "lastActivity lt $($lastActivityLimit.ToString("yyyy-MM-ddTHH:mm:ss")).000Z or lastActivity eq null" # lastActivity is either null (device was not yet active) or less recent than the defined lastActivityLimit
    count = $true
    skip = 0
    top = 100
    select = "deviceName,lastActivity"
    orderby = "lastActivity desc"
}

# Execute the request
$searchResult = Invoke-RestMethod -Method Post -Uri $requestUrl -Authentication Bearer -Token $accessToken -Body ($query | ConvertTo-Json -Depth 100) -ContentType "application/json" -ErrorAction Stop

# Output results
Write-Verbose "Total number of search results: $($searchResult."@odata.count"). Showing $($searchResult.value.Count) search results."
$searchResult.value
