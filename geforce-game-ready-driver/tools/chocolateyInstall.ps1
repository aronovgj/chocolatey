$packageName = 'geforce-game-ready-driver'
$fileType = 'exe'
$silentArgs = '/s'

$url32 = 'http://us.download.nvidia.com/Windows/347.52/347.52-desktop-win8-win7-winvista-32bit-international-whql.exe'
$url64 = 'http://us.download.nvidia.com/Windows/347.52/347.52-desktop-win8-win7-winvista-64bit-international-whql.exe'

try {
	$osBitness = Get-ProcessorBits
	if ($osBitness -eq 32) {
		$url = $url32
	}
	else {
	$url = $url64
	}
	new-item "${env:temp}\nvidiadriver" -itemtype directory
	$unpackfile = "${env:temp}\nvidiadriver\nvidiadriver.zip"
	$unpackdir = "${env:temp}\nvidiadriver"
	Get-ChocolateyWebFile $packageName $unpackfile $url
	Get-ChocolateyUnzip $unpackfile $unpackdir
	$file = "${env:temp}\nvidiadriver\setup.exe"
	Install-ChocolateyInstallPackage $packageName $fileType $silentArgs $file 
	Remove-Item $unpackdir -Recurse -Force
} catch {
    throw $_.Exception 
}