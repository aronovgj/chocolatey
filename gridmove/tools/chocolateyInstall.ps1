$packageName = 'gridmove'
$fileType = 'exe'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
$url = 'http://www.jgpaiva.dcmembers.com/CS/GridMove/GridMoveSetup.exe' 
Stop-Process -ProcessName gridmove*
Install-ChocolateyPackage $packageName $fileType $silentArgs $url
