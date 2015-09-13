#$CommandPath = Split-Path $MyInvocation.MyCommand.Path -Parent
#$ModulePath = "$CommandPath\..\PSPushover"
#Import-Module $ModulePath

$ModuleManifest = "$PSScriptRoot\..\PSPushover\PSPushover.psd1"

Import-Module $ModuleManifest -Force

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

Describe "PSPushover Manifest File" {
    #Reset Module Manifest Variable
    $Script:Manifest = $null

    It "Valid Manifest File" {
        {
            $Script:Manifest = Test-ModuleManifest -Path $ModuleManifest -ErrorAction Stop -WarningAction SilentlyContinue
        } | Should Not Throw
    }

    It "Valid Manifest Root Module" {
        $Script:Manifest.RootModule | Should Be 'PSPushover.psm1'
    }

    It "Valid Manifest Name" {
        $Script:Manifest.Name | Should be PSPushover
    }

    It "Valid Manifest GUID" {
        $Script:Manifest.Guid | SHould be 'aba10845-de65-41ea-b41f-5b003460d601'
    }

    It "Valid Manifest Version" {
        $Script:Manifest.Version -as [Version] | Should Not BeNullOrEmpty
    }

    It "No Format File" {
        $Script:Manifest.ExportedFormatFiles | Should BeNullOrEmpty
    }

    It "Required Modules" {
        $Script:Manifest.RequiredModules | Should BeNullOrEmpty
    }
}

Remove-Module [P]SPushover
