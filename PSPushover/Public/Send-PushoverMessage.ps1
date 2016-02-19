Function Send-PushoverMessage {
<#
.SYNOPSIS
   Actually sends message off to Pushover Devices
.DESCRIPTION
   Uses the Pushover API to send messages via powershell. Requires Save-PushoverAPIInformation first. 
   Devices are auto populated from the list of registered devices with Pushover. Also saves the messages to 
   $PreviousPushoverMessages global variable for status information.  
.EXAMPLE
   Send-PushoverMessage 'This is a test' 'Test 1'
#>
[cmdletbinding()]
param(
    [string]$token = "$(Import-PushoverConfig | Select-Object -ExpandProperty AppToken)",

    [string]$user = "$(Import-PushoverConfig | Select-Object -ExpandProperty UserKey)",

    [Parameter(Mandatory=$true,
               Position=1
    )]
    [string]$message = '',

    [Parameter(Position=2
    )]    
    [string]$title,
    
    [string]$url = '',
    
    [string]$url_title = '',
    
    <#[ValidateSet('pushover','bike','bugle','cashregister','classical','cosmic','falling','gamelan','incoming','intermission','magic','mechanical','pianobar','siren','spacealarm','tugboat','alien','climb','persistent','echo','updown','none')]
    [string]$sound,#>
        
    <#[DateTime]$timestamp,#>

    [ValidateSet('-2','-1','0','1')] 
    [int]$priority = 0

)
DynamicParam {
        $ParameterName = 'device'
        $RuntimeDefinedParameterDictionary = New-Object System.Management.Automation.RuntimeDefinedParameterDictionary
        $AttributeCollection = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
        $ParameterAttribute = New-Object System.Management.Automation.ParameterAttribute
        $AttributeCollection.Add($ParameterAttribute) 
        $devices = Get-PushoverUserDevice
        $ValidateSetAttribute = New-Object System.Management.Automation.ValidateSetAttribute($devices)
        $AttributeCollection.Add($ValidateSetAttribute)
        $RuntimeParameter = New-Object System.Management.Automation.RuntimeDefinedParameter($ParameterName, [string], $AttributeCollection)
        $RuntimeDefinedParameterDictionary.Add($ParameterName, $RuntimeParameter)
        return $RuntimeDefinedParameterDictionary
}

    BEGIN {}
    PROCESS {}
    END {
        $params = @{}
        foreach($h in $MyInvocation.MyCommand.Parameters.GetEnumerator()) {
                $key = $h.Key
                if ($key -match 'Debug|Verbose|OutVariable|WarningVariable|OutBuffer|ErrorVariable|PipelineVariable|ErrorAction|WarningAction') {
                    break;
                }
                $val = Get-Variable -Name $key | Select-Object -ExpandProperty Value
                #Skip Automatic Variables
                if (([String]::IsNullOrEmpty($val) -and (!$PSBoundParameters.ContainsKey($key)))) {
                    break;
                }
                if ($key -eq 'timestamp') {
                    $val = (Get-Date $val.ToUniversalTime() -UFormat %s) -Replace('[,\.]\d*', '') 
             
                }
                $params[$key] = $val
        }

        $Result = $params | Invoke-RestMethod -Uri "$APIURI/messages.json" -Method Post
        $Result | Add-Member -MemberType NoteProperty -Name datetime -Value (Get-Date)
        $Result | Add-Member -MemberType NoteProperty -Name title -Value $params.Title
        #$Result.pstypenames.insert(0,'PSPushover.Response')
        #$Global:PreviousPushMessages += $Results
    }
}
