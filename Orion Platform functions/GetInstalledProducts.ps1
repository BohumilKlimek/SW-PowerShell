#region Function info
    ### PURPOSE:
        ### This function returns all installed products.
        ### It's done via two simple steps:
            ### Information about configured modules is collected ("HKLM\SOFTWARE\Wow6432Node\SolarWinds.Net\ConfigurationWizard\ConfiguredModules").
            ### Based on transformation ("Components.xml" in repository; https://cp.solarwinds.com/x/jqzgAg on Confluence) product(s) version is determined.

    ### INPUT:
        ### No input parameters.

    ### OUTPUT:
        ### PSObject, which will contain list of found products and its version.

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

    ### Loading information about products and its components ("Components.xml"):
        [System.Xml.XmlDocument] $ComponentsInformation = Get-Content -Path ($env:SystemDrive + "\SW-PowerShell-master\Orion Platform data\Components.xml")
    
    ### Creating empty PSObject where output of this function will be stored:
        [System.Management.Automation.PSObject] $InstalledProducts = New-Object PSObject
    
    ### Main function logic - transformation logic:
        foreach ($Component in ($ComponentsInformation.root.Component))
        {
            if ($Component.IsProduct.Value -eq [System.String] "True")
            {
                if ($ConfiguredModules.Contains($Component.Configuration.ID))
                {
                    ### Updating output variable with needed data:
                        Add-Member -InputObject $InstalledProducts -MemberType NoteProperty -Name $Component.Name -Value "TBD"
                }
            }
        }
    
    ### Returning function output:
        return [System.Management.Automation.PSObject] $InstalledProducts
}