$packageName = 'noscript'
$url = 'https://addons.mozilla.org/firefox/downloads/latest/722/addon-722-latest.xpi'
$extensionID = "{73a6fe31-595d-460b-a920-fcc0f8843232}"

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
