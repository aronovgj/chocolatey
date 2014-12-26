$packageName = 'myhotkey'
$url = 'https://onedrive.live.com/download?resid=9E3CAC6AAB07ABA0!10052&authkey=!ADmDXkkLoFnm-Mo&ithint=file%2czip'
$destdir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
Install-ChocolateyZipPackage "$packageName" "$url" "$destdir"

