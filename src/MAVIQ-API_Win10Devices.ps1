<#
.SYNOPSIS
Get a list of the first 20 devices with Windows 10 and include the total count of all Windows 10 devices.
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
    filter = "osWindowsMajorVersion eq 'win10'"
    count = $true
    skip = 0
    top = 20
    select = "deviceName,osWindowsMajorVersion,osWindowsVersion"
    orderby = "deviceName asc"
}

# Execute the request
$searchResult = Invoke-RestMethod -Method Post -Uri $requestUrl -Authentication Bearer -Token $accessToken -Body ($query | ConvertTo-Json -Depth 100) -ContentType "application/json" -ErrorAction Stop

# Output results
Write-Verbose "Total number of search results: $($searchResult."@odata.count"). Showing $($searchResult.value.Count) search results."
$searchResult.value
