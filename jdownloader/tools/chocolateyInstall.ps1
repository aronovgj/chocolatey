﻿$packageName = 'jdownloader'
$installerType = 'EXE'
$url = 'http://installer.jdownloader.org/ic/JD2SilentSetup_x86.exe'
$url64 = 'http://installer.jdownloader.org/ic/JD2SilentSetup_x64.exe'
$silentArgs = '-q'
$validExitCodes = @(0) #please insert other valid exit codes here, exit codes for ms http://msdn.microsoft.com/en-us/library/aa368542(VS.85).aspx

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" "$url64"  -validExitCodes $validExitCodes
