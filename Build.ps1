Task Lint {
    'Lint'
}

Task Pester {
    Import-Module Pester
    $Results = Invoke-Pester -PassThru
    if ($Results.FailedCount -gt 0) {
        $Results.PassedCount
        throw 1
    } 
}

Task default -depends Lint,Pester