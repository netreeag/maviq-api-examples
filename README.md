# MAVIQ API Usage Examples

## Prerequisites

The script examples require at least PowerShell v7.x to work.

You can still use Windows PowerShell to access the MAVIQ API, you just need to change the examples.

The script examples require the PowerShell module `Az.Accounts` 2.x to aquire an authentication token to access the MAVIQ API.

```powershell
Install-Module Az.Accounts
```

## Usage

Fill out the configuration file `config.jsonc` and test the example scripts.

To create a secure string that you can put into the configuration file (application client secret) you can use the following command:

```powershell
Read-Host -Prompt "Enter password to encrypt" -AsSecureString | ConvertFrom-SecureString
```

The script `MAVIQ-API_Authenticate.ps1` is being called by all the other scripts to aquire an access token.
