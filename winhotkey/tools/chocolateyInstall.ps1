$packageName = 'winhotkey'
$fileType = 'exe'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
$url = 'http://www.directedge.us/files/whk/WinHotKey0.70.exe' 
Stop-Process -ProcessName WinHotKey*
Install-ChocolateyPackage $packageName $fileType $silentArgs $url
