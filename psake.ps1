Properties {
    # Find the build folder based on build system
        $ProjectRoot = $ENV:BHProjectPath
        if(-not $ProjectRoot)
        {
            $ProjectRoot = $PSScriptRoot
        }

    $Timestamp = Get-date -uformat "%Y%m%d-%H%M%S"
    $PSVersion = $PSVersionTable.PSVersion.Major
    $TestFile = "TestResults_PS$PSVersion`_$TimeStamp.xml"
    #$lines = '----------------------------------------------------------------------'

    $Verbose = @{}
    if($ENV:BHCommitMessage -match "!verbose")
    {
        $Verbose = @{Verbose = $True}
    }
}

Task ScriptAnalyzer {
    $ScriptAnalysis = Invoke-ScriptAnalyzer -Path $projectRoot -Severity @('Error') -Recurse
    if ( $ScriptAnalysis) { 
        $ScriptAnalysis | Format-Table
        Write-Error -Message "Errors/Warnings Found $($ScriptAnalysis.Count)"    
    }

}

Task Pester {
    Import-Module Pester
    $Results = Invoke-Pester -PassThru -Quiet
    if ($Results.FailedCount -gt 0) {
        $Results.PassedCount
        throw 1
    } 
}

Task default -depends ScriptAnalyzer,Pester