#$CommandPath = Split-Path $MyInvocation.MyCommand.Path -Parent
#$ModulePath = "$CommandPath\..\PSPushover"
#Import-Module $ModulePath

Import-Module $PSScriptRoot\..\PSPushover\PSPushover.psd1 -Force

Describe "Save-PushoverAPIInformation" {
    It "Proper Format" {
        { Save-PushoverAPIInformation -UserKey 'ExampleUserKey' -AppToken 'ApplicationToken' } | Should not throw
    }

    It "No UserKey" {
        { Save-PushoverAPIInformation -UserKey $null -AppToken 'ApplicationToken' } | Should Throw
    }

    It "No App Token" {
        { Save-PushoverAPIInformation -UserKey 'ExampleUserKey' -AppToken $null } | Should Throw
    }
}

Remove-Module [P]SPushover