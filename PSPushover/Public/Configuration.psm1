$ConfigPath = "$env:appdata\PSGitLab\PSPushoverConfiguration.xml"

Function Save-PushoverAPIInformation {
[cmdletbinding()]
param(
    
    [parameter(Mandatory=$True)]
    [ValidateNotNull()]
    [string]$UserKey,
    
    [parameter(Mandatory=$True)]
    [ValidateNotNull()]
    [string]$AppToken

)

    $ReturnObject = New-Object -TypeName psobject -Property @{
        UserKey=$UserKey
        AppToken=$AppToken
    }
    Write-Verbose "Saving Pushover API information to $ConfigPath"
    if (-not (Test-Path (Split-Path $ConfigPath))) {
        New-Item -ItemType Directory -Path (Split-Path $ConfigPath) | Out-Null
    }
    $ReturnObject | Export-clixml -Path $ConfigPath

}