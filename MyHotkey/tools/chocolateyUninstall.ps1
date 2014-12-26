$packageName = 'myhotkey'
$binRoot = Get-BinRoot
$destdir = Join-Path $binRoot $packageName
try {
Stop-Process -ProcessName myHotkey*
Remove-Item $destdir -Recurse -Force
} catch {
Write-ChocolateyFailure $packageName $($_.Exception.Message)
throw
}
