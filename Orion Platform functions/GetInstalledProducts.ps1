#region Function info
    ### PURPOSE:
        ### This function returns all installed products and its versions.
        ### It's done via two simple steps:
            ### Information about configured modules is collected ("HKLM\SOFTWARE\Wow6432Node\SolarWinds.Net\ConfigurationWizard\ConfiguredModules").
            ### Based on transformation ("ConfiguredModules.xml" in repository; https://cp.solarwinds.com/x/jqzgAg on Confluence) product(s) version is determined.

    ### INPUT:
        ### No input parameters.

    ### OUTPUT:
        ### PSObject, which will contain list of found products and its versions.

    ### DEPENDENCIES:
        ### "GetBitPlatfrom.ps1" has to be loaded.

        ### No function nor script depends on this function.

    ### KNOWN LIMITATION(S):
        ### No limitations.
#endregion  

### Loading dependencies:
    . ($env:SystemDrive + "\SW-PowerShell-master\Common functions\Environment\GetBitPlatform.ps1")

function GetInstalledProducts ()
{ 
    ### Determining SolarWinds registry root folder:
        if (GetBitPlatfrom -eq "64bit")
	    {
		    [System.String] $SolarWindsRegistryRoot = "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\SolarWinds\"
            [System.String] $SolarWindsNetRegistryRoot = "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\SolarWinds.Net\"
        }
   	    elseif (GetBitPlatfrom -eq "32bit")
        {
		    [System.String] $SolarWindsRegistryRoot = "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\SolarWinds\"
            [System.String] $SolarWindsNetRegistryRoot = "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\SolarWinds.Net\"
	    }

    ### Reading configured modules values:
        [System.String[]] $ConfiguredModules = (Get-item -Path ($SolarWindsNetRegistryRoot + "ConfigurationWizard\ConfiguredModules")).Property

    ### Loading transformation matrix ("ConfiguredModules.xml"):
        [System.Xml.XmlDocument] $TransformationMatrix = Get-Content -Path ($env:SystemDrive + "\SW-PowerShell-master\Orion Platform data\ConfiguredModules.xml")
    
    ### Main function logic - transformation logic:
        foreach ($ConfiguredModule in ($TransformationMatrix.root.ConfiguredModule | Where-Object {$_.IsProduct -eq "True"}))
        {
            if ($ConfiguredModules.Contains($ConfiguredModule.ID))
            {
                ### TO BE EVEN TESTED....
            }
        }
    
    ### return TBD																	   
}