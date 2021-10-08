# MAVIQ API Usage Examples

These script examples require at least PowerShell v7.x to work. You can still use Windows PowerShell to access the MAVIQ API, you just need to change the examples.

Fill out the configuration file `config.jsonc` and test the example scripts. The script `MAVIQ-API_Authenticate.ps1` is being called by all the other scripts to aquire an access token to access the MAVIQ API.

To create a secure string that you can put into the configuration file (application client secret) you can use the following command:

```powershell
"password123" | ConvertTo-SecureString -AsPlainText -Force | ConvertFrom-SecureString
```
