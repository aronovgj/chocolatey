$packageName = 'myhotkey'
$destdir = "${env:programfiles(x86)}\MyHotkey"
try {
Remove-Item $destdir -Recurse -Force
} catch {
Write-ChocolateyFailure $packageName $($_.Exception.Message)
throw
}
