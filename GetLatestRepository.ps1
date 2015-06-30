#region Script info
    ### PURPOSE:
        ### This script downloads whole PowerShell repository from GitHub ("https://github.com/BohumilKlimek/SW-PowerShell").
        ### It's done via two simple steps:
            ### Whole PowerShell repository is downloaded via usage of repository direct link ("https://github.com/BohumilKlimek/SW-PowerShell/archive/master.zip").
            ### Whole repository is then extracted to "C:\SW-PowerShell-master\" folder (in case C is system hard drive letter).
                
    ### INPUT:
        ### No input parameters as this is not function.

    ### OUTPUT:
        ### No output as this is not function.

    ### DEPENDENCIES:
        ### "ExtractZipFile.ps1" has to be loaded.

        ### No function nor script depends on this function.

    ### KNOWN LIMITATION(S):
        ### There is inherited limitation from "ExtractZipFile" function, so if "C:\SW-PowerShell-master\" folder will be detected (in case C is system hard drive letter), this folder will be deleted.
#endregion

Clear-Host

### Loading dependencies:
    #Invoke-WebRequest -Uri "https://raw.githubusercontent.com/BohumilKlimek/SW-PowerShell/master/Common%20functions/Zip/ExtractZipFile.ps1" -OutFile ($env:TEMP + "\ExtractZipFile.ps1")
    #. ($env:TEMP + "\ExtractZipFile.ps1")

### Deleting "C:\SW-PowerShell-master\" folder (in case C is system hard drive letter) in case it already exists:
    if (Test-Path ($env:SystemDrive + "\SW-PowerShell-master\"))
    {
        Remove-Item -Path ($env:SystemDrive + "\SW-PowerShell-master\") -Recurse -Force
    }

### Downloading PowerShell repository:
    Invoke-WebRequest -Uri "https://github.com/BohumilKlimek/SW-PowerShell/archive/master.zip" -OutFile ($env:TEMP + "\master.zip")

### Extracting PowerShell repository:
    ExtractZipFile ([System.String] $env:TEMP + "\master.zip") ([System.String] $env:SystemDrive + "\")