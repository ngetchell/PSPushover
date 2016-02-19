$ModuleName = Split-Path (Resolve-Path "$PSScriptRoot\..\" ) -Leaf
$ModuleManifest = Resolve-Path "$PSScriptRoot\..\$ModuleName\$ModuleName.psd1"

Import-Module $ModuleManifest

InModuleScope $ModuleName {
    Describe 'Send-PushoverMessage' {

        Context 'Mocking Functions' { 
            It 'Mocking Invoke-RestMethod' { 
                Mock Invoke-RestMethod {}
                #Mock Add-Member {}
                Mock Get-PushoverUserDevice { 'ExampleDevice' }

                $Results = Send-PushoverMessage -title 'Example Title' -Message 'Blank Message' -device 'ExampleDevice'

                #Assert-MockCalled Import-PushoverConfg 1
                Assert-MockCalled Invoke-RestMethod 1
            }
        }
    }
}

Remove-Module $ModuleName