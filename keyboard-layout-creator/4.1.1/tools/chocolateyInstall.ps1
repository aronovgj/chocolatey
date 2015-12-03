# To install and use MSKLC 1.4, your system must meet the following requirements:
# Windows 2000, Windows XP, Windows Server 2003, Windows Vista, or Windows 7. (MSKLC 1.4 will not run on Windows 95, Windows 98, Windows ME, or Windows NT 4.)
# Microsoft .NET Framework v2.0 must be installed. If you have not already installed this version of the .NET Framework, you can do so from the following URL: http://msdn2.microsoft.com/en-us/netframework/aa731542.aspx
# Note that MSKLC 1.4 is a 32-bit application. It will run on 64-bit systems, but in 32-bit mode.

function Test-OSVersion
{
    [CmdLetBinding()]
    [OutputType([bool])]
    param
    (
        [Parameter(Mandatory=$True)]
        [version]$OSRequiredVersion,
        [Parameter(Mandatory=$false)]
        $CheckAgaintWorkstationVersionOnly=$True
    )

    [version]$currentOSVersion = [System.Environment]::OSVersion.Version
    Write-Debug "Current OS Version: $currentOSVersion"
    
    [string]$operatingSystemCaption = (Get-WmiObject -class Win32_OperatingSystem).Caption
    Write-Debug "Current OS Name: $operatingSystemCaption"

    [bool]$matchRequiredOsVersion = $false

    if ($($currentOSVersion.Major -eq $OSRequiredVersion.Major) -and $($currentOSVersion.Minor -eq $OSRequiredVersion.Minor))
    {
        $matchRequiredOsVersion = $True

        if (-not $CheckAgaintWorkstationVersionOnly)
        {
            [bool]$isWindowsServer = $operatingSystemCaption.ToUpperInvariant().Contains("SERVER")
            $matchRequiredOsVersion = !$isWindowsServer
        }
    }

    return $matchRequiredOsVersion
}

[bool]$isWindowsServer2012R2 = $(Test-OSVersion "6.3" $false)

if ($isWindowsServer2012R2)
{
    # [TODO] Improve the error message
    throw "OS not supported."
}
else
{
    # Copy and paste from current package
    $packageName = 'keyboard-layout-creator'
    $fileType = 'msi'
    $silentArgs = '/qn'
    $url = 'http://download.microsoft.com/download/1/1/8/118aedd2-152c-453f-bac9-5dd8fb310870/MSKLC.exe'

    $unpackDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
    $unpackFile = Join-Path $unpackDir 'mklc.zip'

    Get-ChocolateyWebFile $packageName $unpackFile $url
    Get-ChocolateyUnzip $unpackFile $unpackDir
    $fileMsi = Join-Path $unpackDir "MSKLC.msi"
    $fileExe = Join-Path $unpackDir "setup.exe"

    Install-ChocolateyInstallPackage $packageName $fileType $silentArgs $fileMsi
    Remove-Item $unpackFile -Recurse -Force
    Remove-Item $fileExe -Recurse -Force
    Remove-Item $fileMsi -Recurse -Force
}
