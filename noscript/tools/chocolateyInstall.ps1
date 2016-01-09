$packageName = 'noscript'
$url = 'https://addons.mozilla.org/firefox/downloads/latest/722/addon-722-latest.xpi'
$extensionID = "{73a6fe31-595d-460b-a920-fcc0f8843232}"
$profileFolder = gci -path "$env:APPDATA\Mozilla\Firefox\Profiles" -filter "*default*" | Select-Object -Expand FullName
$extensionsFolder = Join-Path $profileFolder "extensions"
$extFolder = Join-Path $extensionsFolder "$extensionID"
New-Item -ItemType directory -Path $extFolder
Install-ChocolateyZipPackage "$packageName" "$url" "$extFolder"