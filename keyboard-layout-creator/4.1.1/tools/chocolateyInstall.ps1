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
$isWindowsServer2012R2=$true
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