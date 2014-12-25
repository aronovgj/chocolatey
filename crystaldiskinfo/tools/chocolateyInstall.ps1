$packageName = 'crystaldiskinfo'
$installerType = 'EXE'
$url = 'http://www.sourceforge.jp/frs/redir.php?m=iij&f=%2Fcrystaldiskinfo%2F61888%2FCrystalDiskInfo6_2_2-en.exe'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$validExitCodes = @(0) #please insert other valid exit codes here, exit codes for ms http://msdn.microsoft.com/en-us/library/aa368542(VS.85).aspx
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url"  -validExitCodes $validExitCodes
