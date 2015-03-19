$packageName = 'myhotkey'
$url = 'https://onedrive.live.com/download?resid=9E3CAC6AAB07ABA0!10052&authkey=!ADmDXkkLoFnm-Mo&ithint=file%2czip'
$fileName = "myHotkey.exe"
$linkName = "myHotkey.lnk"
$destdir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
Install-ChocolateyZipPackage "$packageName" "$url" "$destdir"

#install start menu shortcut
$programs = [environment]::GetFolderPath([environment+specialfolder]::Programs)
$shortcutFilePath = Join-Path $programs $linkName 
$targetPath = Join-Path $destdir $fileName
Install-ChocolateyShortcut -shortcutFilePath $shortcutFilePath -targetPath $targetPath