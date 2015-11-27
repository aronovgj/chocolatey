# To install and use MSKLC 1.4, your system must meet the following requirements:
# Windows 2000, Windows XP, Windows Server 2003, Windows Vista, or Windows 7. (MSKLC 1.4 will not run on Windows 95, Windows 98, Windows ME, or Windows NT 4.)
# Microsoft .NET Framework v2.0 must be installed. If you have not already installed this version of the .NET Framework, you can do so from the following URL: http://msdn2.microsoft.com/en-us/netframework/aa731542.aspx
# Note that MSKLC 1.4 is a 32-bit application. It will run on 64-bit systems, but in 32-bit mode.

function Get-NetFrameworkSetupVersions
{
    Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP' -recurse |
    Get-ItemProperty -name Version,Release -EA 0 |
    Where { $_.PSChildName -match '^(?!S)\p{L}'} |
    Select PSChildName, Version, Release
}

function Test-NetFrameworkSetupVersion
{
    [CmdLetBinding()]
    [OutputType([bool])]
    param
    (
        [Parameter(Mandatory=$True)]
        [Version]$MinimumNetVersionRequired
    )

    $installedNetFrameworkInstalledVersions = Get-NetFrameworkSetupVersions | Select Version

    [bool]$hasMinimumVersionInstalled = $false

    foreach ($installedNetFrameworkInstalledVersion in $installedNetFrameworkInstalledVersions)
    {   
        Write-Debug "Installed .Net version: $($installedNetFrameworkInstalledVersion.Version)"
        if ($installedNetFrameworkInstalledVersion.Version -ge $MinimumNetVersionRequired) 
        { 
            $hasMinimumVersionInstalled = $true
            break
        }
    }

    return $hasMinimumVersionInstalled
}

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

    [bool]$matchRequiredOsVersion = $false

    if ($($currentOSVersion.Major -eq $OSRequiredVersion.Major) -and $($currentOSVersion.Minor -eq $OSRequiredVersion.Minor))
    {
        $matchRequiredOsVersion = $True

        if (-not $CheckAgaintWorkstationVersionOnly)
        {
            [bool]$isWindowsServer = (Get-WmiObject -class Win32_OperatingSystem).Caption.ToUpperInvariant().Contains("SERVER")
            $matchRequiredOsVersion = !$isWindowsServer
        }
    }

    return $matchRequiredOsVersion
}

if ($(Test-OSVersion "5.0") -or # Windows 2000
    $(Test-OSVersion "5.1") -or # Windows XP
    $(Test-OSVersion "5.2" $false) -or # Windows Server 2003
    $(Test-OSVersion "6.0") -or # Windows Vista
    $(Test-OSVersion "6.1")) # Windows 7
{
    if (Test-NetFrameworkSetupVersion "2.0")
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
    else
    {
        Write-Warning "You need to install .NET Framework 2.0 or later. Use `"Choco Install dotnet4.5.1`" or for other versions have a look at: https://chocolatey.org/packages?q=dotnet"
    }
}
else
{
    # [TODO] Improve the error message
    Write-Warning "OS not supported."
}
