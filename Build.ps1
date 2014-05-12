$currentDir = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition

$output = . "$currentDir\GitVersion.1.0.0.0\tools\GitVersion.exe"
$joined = $output -join "`n"
$versionInfo = $joined | ConvertFrom-Json

(Get-Content "$currentDir\src\UsefulStuff.psm1") | 
    Foreach-Object {$_ -replace '__version__',"v$versionInfo.SemVer"} |
    Out-File "$currentDir\src\UsefulStuff.psm1"