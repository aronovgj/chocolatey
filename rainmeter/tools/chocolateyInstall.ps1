$packageName = 'rainmeter'
$url = 'https://github.com/rainmeter/rainmeter/releases/download/v3.2.0.2383/Rainmeter-3.2-r2383-rc1.exe'
$silentArgs = '/S /PORTABLE=0 /STARTUP=1'
$osBitness = Get-ProcessorBits
if ($osBitness -eq 64) {
	$silentArgs = '/S /VERSION=64 /PORTABLE=0 /STARTUP=1'
}
$fileType = 'exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url
