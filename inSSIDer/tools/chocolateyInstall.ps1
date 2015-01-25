$packageName = 'inssider'
$fileType = 'MSI'
$silentArgs = '/passive'
$url = 'http://files01.techspot.com/temp/inSSIDer-installer.msi' 
$validExitCodes = @(0) #please insert other valid exit codes here, exit codes for ms http://msdn.microsoft.com/en-us/library/aa368542(VS.85).aspx

Install-ChocolateyPackage $packageName $fileType $silentArgs $url -validExitCodes @(0)