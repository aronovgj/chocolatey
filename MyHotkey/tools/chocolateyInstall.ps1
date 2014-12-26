$packageName = 'myhotkey'
#mkdir "$env:programfiles (x86)\MyHotkey"

$installDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$binRoot = Get-BinRoot
$destdir = Join-Path $binRoot $packageName

#$destdir = "${env:programfiles(x86)}\MyHotkey"
$url = 'https://onedrive.live.com/download?resid=9E3CAC6AAB07ABA0!10052&authkey=!ADmDXkkLoFnm-Mo&ithint=file%2czip'
Install-ChocolateyZipPackage "$packageName" "$url" "$destdir"
