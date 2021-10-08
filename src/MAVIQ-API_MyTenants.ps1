<#
.SYNOPSIS
Get a list of all the MAVIQ tenants the token has access to.
#>
[CmdletBinding()]
param()

<# Authentication #>

# Authenticate / Get access token
. (Join-Path $PSScriptRoot "MAVIQ-API_Authenticate.ps1")

<# Request #>

# Execute the request
Invoke-RestMethod -Method Get -Uri "$($maviqApiRootUrl)my" -Authentication Bearer -Token $accessToken -ErrorAction Stop
