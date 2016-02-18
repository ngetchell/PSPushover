Function Import-PushoverConfig {
<#
.Synopsis
   Check for configuration and output the information.
.DESCRIPTION
   Check for configuration and output the information. Goes into the $env:appdata for the configuration file.
.EXAMPLE
    ImportConfig
#>
    if (Test-Path $ConfigPath) {
        Import-Clixml $ConfigPath

    } else {
        Write-Warning 'No Saved Configration Information. Run Save-PushoverAPIInformation.'
        break;
    }

}