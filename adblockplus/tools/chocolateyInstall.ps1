$packageName = 'adblockplus-firefox'
$url = 'https://addons.mozilla.org/firefox/downloads/latest/1865/addon-1865-latest.xpi'
$extensionID = "{d10d0bf8-f5b5-c8b4-a8b2-2b9879e08c5d}"

if(test-path 'hklm:\SOFTWARE\Mozilla\Firefox\TaskBarIDs'){
	$installDir = Get-Item -Path Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Mozilla\Firefox\TaskBarIDs | Select-Object -ExpandProperty Property
}
if(test-path 'hklm:\SOFTWARE\Wow6432Node\Mozilla\Firefox\TaskBarIDs'){
	$installDir = Get-Item -Path Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Mozilla\Firefox\TaskBarIDs | Select-Object -ExpandProperty Property
}

$browserFolder = Join-Path $installDir "browser"
$extensionsFolder = Join-Path $browserFolder "extensions"
$extFolder = Join-Path $extensionsFolder "$extensionID"
if (!(Test-Path $extFolder)) {
	New-Item -Force -ItemType directory -Path $extFolder 
	Install-ChocolateyZipPackage "$packageName" "$url" "$extFolder"
}
else {
	Write-Host "$packageName already exists"
}
