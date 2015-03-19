$linkName = "myHotkey.lnk"
$programs = [environment]::GetFolderPath([environment+specialfolder]::Programs)
$shortcutFilePath = Join-Path $programs $linkName

if(Test-Path $shortcutFilePath) {
    del $shortcutFilePath
}