$ModuleName = Split-Path (Resolve-Path "$PSScriptRoot\..\" ) -Leaf
$ModuleManifest = Resolve-Path "$PSScriptRoot\..\$ModuleName\$ModuleName.psd1"

Import-Module $ModuleManifest

Get-Command -Module $ModuleName | ForEach-Object {
    Describe 'Help' -Tags 'Help' {
        Context "Function - $_" { 
            It 'Synopsis' {
                Get-Help $_ | Select-Object -ExpandProperty synopsis | should not benullorempty
            }
            It 'Description' {
                Get-Help $_ | Select-Object -ExpandProperty Description | should not benullorempty
            }
            It 'Examples' {
            
                $Examples = Get-Help $_ | Select-Object -ExpandProperty Examples | Measure-Object 
                $Examples.Count -gt 0 | Should be $true
            }
        }
    }
}

Describe 'Module Information' -Tags 'Command'{
    Context 'Manifest Testing' { 
        It 'Valid Module Manifest' {
            {
                $Script:Manifest = Test-ModuleManifest -Path $ModuleManifest -ErrorAction Stop -WarningAction SilentlyContinue
            } | Should Not Throw
        }
        It 'Valid Manifest Name' {
            $Script:Manifest.Name | Should be $ModuleName
        }
        It 'Generic Version Check' {
            $Script:Manifest.Version -as [Version] | Should Not BeNullOrEmpty
        }
        It 'Valid Manifest Description' {
            $Script:Manifest.Description | Should Not BeNullOrEmpty
        }
        It 'Valid Manifest Root Module' {
            $Script:Manifest.RootModule | Should Be "$ModuleName.psm1"
        }
        It 'Valid Manifest GUID' {
            $Script:Manifest.Guid | SHould be 'aba10845-de65-41ea-b41f-5b003460d601'
        }
        It 'No Format File' {
            $Script:Manifest.ExportedFormatFiles | Should BeNullOrEmpty
        }

        It 'Required Modules' {
            $Script:Manifest.RequiredModules | Should BeNullOrEmpty
        }
    }

    Context 'Exported Functions' {
        It 'Proper Number of Functions Exported' {
            $ExportedCount = Get-Command -Module $ModuleName | Measure-Object | Select-Object -ExpandProperty Count
            $FileCount = Get-ChildItem -Path "$PSScriptRoot\..\$ModuleName\Public" -Filter *.ps1 | Measure-Object | Select-Object -ExpandProperty Count

            $ExportedCount | Should be $FileCount

        }
    }

}    

Remove-Module $ModuleName