$ErrorActionPreference = 'Stop';
$packageName= 'google-books-downloader'
$url        = 'https://googlebookdownloader.codeplex.com/downloads/get/1427613' 

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  url           = $url
}

Install-ChocolateyPackage @packageArgs