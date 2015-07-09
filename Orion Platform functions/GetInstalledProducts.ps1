#region Function info
    ### PURPOSE:
        ### This function returns all installed products.
        ### It's done via three simple steps:
            ### Information about configured modules is collected ("HKLM\SOFTWARE\Wow6432Node\SolarWinds.Net\ConfigurationWizard\ConfiguredModules").
            ### Based on information in "Components.xml" is determined if configured module is product or not.
            ### Products version is obtained from module.xml.

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
    ### Determining SolarWinds registry root folders and installation path:
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

    ### Determining installation path based on bit platform:
        [System.String] $InstallationPath = (Get-ItemProperty -Path ($SolarWindsRegistryRoot + "Orion\Core")).InstallPath

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
                    ### Loading component's module.xml to get external product version:
                        [System.Xml.XmlDocument] $ModuleConfiguration = Get-Content -Path ($InstallationPath + "Modules\" + $Component.ModuleName + ".xml")
                    
                        ### Getting external product version from module.xml:
                            $ExternalProductVersion = $ModuleConfiguration.OrionModule.Info.ModuleVersion 
                    
                    ### Updating output variable with all data:
                        Add-Member -InputObject $InstalledProducts -MemberType NoteProperty -Name $Component.Name -Value $ExternalProductVersion
                }
            }
        }
    
    ### Returning function output:
        return [System.Management.Automation.PSObject] $InstalledProducts
}