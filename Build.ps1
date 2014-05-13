$currentDir = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition

$output = . "$currentDir\GitVersion.1.0.0.0\tools\GitVersion.exe"

$joined = $output -join "`n"
$versionInfo = $joined | ConvertFrom-Json
$version = $versionInfo.SemVer

mkdir "$currentDir\Artifacts"

Copy-Item "$currentDir\src\UsefulStuff.psm1" "$currentDir\Artifacts\UsefulStuff.psm1"

(Get-Content "$currentDir\Artifacts\UsefulStuff.psm1") | 
    Foreach-Object {$_ -replace '__version__',"v$version"} |
    Out-File "$currentDir\Artifacts\UsefulStuff.psm1"
    
Write-Output "##teamcity[buildNumber '$version']"