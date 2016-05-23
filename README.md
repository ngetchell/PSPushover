# PSPushover

[![Build status](https://ci.appveyor.com/api/projects/status/pjvxerp8fodakbo7/branch/master?svg=true)](https://ci.appveyor.com/project/ngetchell/pspushover/branch/master) 

A PowerShell module for working with the [Pushover](https://pushover.net) API from the command line.

## Why PSPushover

Sometimes you need to surface important alerts to your mobile device and desktop from your PowerShell scripts. 

## Examples

### Save Configuration

Run this before any other cmdlets to make sure you can communicate with your mobile devices. 

``` powershell
Save-PushoverAPIInformation
```

### Sending An Alert

``` powershell
Send-PushoverMessage -Title "Error Alert" -Message "Error occured today."
```

## Installing

![Install](Media/install.gif)

## Contributing

### Submitting a Pull Request

1. Fork it.
2. Create a branch (`git checkout -b my_markup`)
3. Commit your changes (`git commit -am "Added Snarkdown"`)
4. Push to the branch (`git push origin my_markup`)
5. Open a [Pull Request][1]

### Testing

PSPushover uses the Pester Testing Framework for all testing. 

``` powershell
Invoke-Pester -Path "path\to\project\"
```

### Static Analysis

Since PSPushover is included in the PowerShell Gallery it must also pass the PSScriptAnalyzer static analysis to make sure your code complies with community standards.

``` powershell
Find-Module -Name PSScriptAnalyzer | Install-Module
Invoke-ScriptAnalyzer -Path "path\To\project\"
```

[1]: http://github.com/github/markup/pulls