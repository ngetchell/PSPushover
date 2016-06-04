$ModuleName = Split-Path (Resolve-Path "$PSScriptRoot\..\" ) -Leaf
$ModuleManifest = Resolve-Path "$PSScriptRoot\..\$ModuleName\$ModuleName.psd1"

Import-Module $ModuleManifest

InModuleScope $ModuleName {
    Describe 'Send-PushoverMessage' {

        Mock Invoke-RestMethod { 
            [pscustomobject]@{
                request='2d059b71f10fc1c98f3aab3c7bc7f899'
                status=1
            }
        }

        Context 'Mocking Functions' { 
            It 'Mocking Invoke-RestMethod' { 
                #Mock Invoke-RestMethod {}
                #Mock Add-Member {}
                Mock Get-PushoverUserDevice { 'ExampleDevice' }

                $Results = Send-PushoverMessage -title 'Example Title' -Message 'Blank Message' -device 'ExampleDevice'

                #Assert-MockCalled Import-PushoverConfg 1
                Assert-MockCalled Invoke-RestMethod 1
            }
        }
        Context 'Checking PassThru Parameter' { 
             

            
            Mock Get-PushoverUserDevice { 'ExampleDevice' }

            $Results = Send-PushoverMessage -title 'Example Title' -Message 'Blank Message' -device 'ExampleDevice' -PassThru

            It "Title Check" {
                $Results.Title | Should be 'Example Title'
            }
            
            It "Status Check" {
                $Results.Status | Should be 1
            }
            
            It "Request Check" {
                $Results.Request | Should be '2d059b71f10fc1c98f3aab3c7bc7f899'
            }
            
            It "Success Check" {
                $Results.Success | Should be $true
            }
            
            It "Date Check" {
                $Results.DateTime | Should not benullorempty
            }

        }        
        
        Context "Bad Message" {
            Mock Invoke-RestMethod { 
                [pscustomobject]@{
                    request='3d059b71f10fc1c98f3aab3c7bc7f899'
                    status=2
                }
            }            
            
            Mock Get-PushoverUserDevice { 'ExampleDevice' }

            $Results = Send-PushoverMessage -title 'Example Title' -Message 'Blank Message' -device 'ExampleDevice' -PassThru
            
            It "Status Check" {
                $Results.Status | Should be 2
            }
            
            It "Success False" {
                $Results.Success | Should be $false
            }
            
        }
    }
}

Remove-Module $ModuleName