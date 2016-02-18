$ModuleName = Split-Path (Resolve-Path "$PSScriptRoot\..\" ) -Leaf
$ModuleManifest = Resolve-Path "$PSScriptRoot\..\$ModuleName\$ModuleName.psd1"

Import-Module $ModuleManifest

InModuleScope $ModuleName {
    Describe 'Get-PushoverUserDevice' {

        Context 'Mocking Functions' { 
            It 'Mocking Invoke-RestMethod' { 
                #Mock Import-PushoverConfig {}
                Mock Invoke-RestMethod {}

                $Results = Get-PushoverUserDevice 

                #Assert-MockCalled Import-PushoverConfg 1
                Assert-MockCalled Invoke-RestMethod 1
            }
        }
    }
}

Remove-Module $ModuleName