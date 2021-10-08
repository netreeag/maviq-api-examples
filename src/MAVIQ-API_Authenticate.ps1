<#
.SYNOPSIS
This script does a one-way synchronization of netUNIMEX groups with Microsoft Teams teams.
#>
[CmdletBinding()]
param()

<# Configuration #>

$config = Get-Content (Join-Path $PSScriptRoot "config.jsonc") -Encoding utf8 | ConvertFrom-Json

# Azure AD directory/tenant ID
$azureAdTenantId = $config.azureAdTenantId

# Application information (from Azure AD App registration)
$appClientId = $config.appClientId
$appClientSecret = $config.appClientSecret | ConvertTo-SecureString

# MAVIQ tenant to use for requests
$maviqTenantId = $config.maviqTenantId

# MAPIQ API root URL
$maviqApiRootUrl = "https://api.maviq.com/"

<# Prerequisites #>

Import-Module Az.Accounts -ErrorAction Stop

<# Authentication #>

$credential = New-Object PSCredential -ArgumentList @($appClientId, $appClientSecret)

# Connect as an Azure AD application (service principal)
$azProfile = Connect-AzAccount -Credential $credential -Tenant $azureAdTenantId -ServicePrincipal -ErrorAction Stop

# Get an access token for the MAVIQ API and convert it to a secure string
$accessToken = Get-AzAccessToken -ResourceUrl $maviqApiRootUrl -ErrorAction Stop | Select-Object -ExpandProperty Token | ConvertTo-SecureString -AsPlainText -Force

# Disconnect
Disconnect-AzAccount -AzureContext $azProfile.Context | Out-Null
