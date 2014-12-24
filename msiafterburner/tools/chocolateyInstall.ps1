$packageName = 'msiafterburner'
new-item "${env:temp}\afterburner" -itemtype directory
$unpackfile = "${env:temp}\afterburner\afterburner.zip"
$unpackdir = "${env:temp}\afterburner"
$url = 'http://download.msi.com/uti_exe/vga/MSIAfterburnerSetup301.zip'
Get-ChocolateyWebFile $packageName $unpackfile $url

Get-ChocolateyUnzip $unpackfile $unpackdir

$file = "${env:temp}\afterburner\MSIAfterburnerSetup301.exe"
$fileType = 'exe'
$silentArgs = '/S'
Stop-Process -ProcessName MSIAfterburner*
Install-ChocolateyInstallPackage $packageName $fileType $silentArgs $file
