$packageName = 'hijackthis'
$url = 'http://downloads.sourceforge.net/project/hjt/2.0.5%20beta/HijackThis.exe?r=&ts=1435519734&use_mirror=garr'
$fileName = "HijackThis.exe"
$linkName = "HijackThis.lnk"
$destdir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$destFileName = Join-Path $destdir $fileName
If (Test-Path $destFileName){
	Remove-Item $destFileName
}
Get-ChocolateyWebFile $packageName $destFileName $url

#install start menu shortcut
$programs = [environment]::GetFolderPath([environment+specialfolder]::Programs)
$shortcutFilePath = Join-Path $programs $linkName 
$targetPath = Join-Path $destdir $fileName
Install-ChocolateyShortcut -shortcutFilePath $shortcutFilePath -targetPath $targetPath