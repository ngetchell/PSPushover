Function Get-PushoverUserDevice {
<#
.SYNOPSIS
   Retrieves a list of registered devices with Pushover. 
.DESCRIPTION
   Retrieves a list of registered devices with Pushover. Useful for trying to gather all of the possible devices to send to. 
.EXAMPLE
   Get-PushoverUserDevices
   Nexus7
   Blackfyre
#>
    
    $Config = Import-PushoverConfig

    $Parameters = @{
        token=$Config.AppToken;
        user=$Config.UserKey;
    }
    
    $Results = $Parameters | Invoke-RestMethod -Uri "$APIURI/users/validate.json" -Method Post
    Write-Output $Results.devices
}