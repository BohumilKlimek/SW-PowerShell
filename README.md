### SW-PowerShell
* This is the main repository for all PowerShell scripts with any relation to SolarWinds.

### How to download whole repository to your system?
* Just execute "GetLatestRepository.ps1" stored in root of this repository.

### Action items
* Add function for detecting correct version of PowerShell (script execution will be blocked, if lover than 4.0).
* Start working on “GetComponentsVersion.ps1”, which will be in Tools container.
* ..Intent here is to have pluggable script, which will do its work based on present plugins.
* ..Next needed piece is xml (ProductsInformation.xml), where basic needed information will be stored.
* ....Information about IsProduct, whould be moved from ConfiguredModules.xml into ProductsInformation.

### Long term ideas
* Create function, which will detect .NET version.

### Content structure + plain description
* SW-PowerShell  
* ..Common functions (DESCRIPTION: container for all generic functions)
* ....Environment (DESCRIPTION: logical container)
* ......GetBitPlatform.ps1 (DESCRIPTION: function for distinguishing between 32 and 64 platforms)
* ....Zip (DESCRIPTION: logical container)
* ......ExtractZipFile.ps1 (DESCRIPTION: function for extracting zip files)
* ..Orion Platform data (DESCRIPTION: container for all Orion Platform data files)
* ....ConfiguredModules.xml (DESCRIPTION: configuration IDs for Orion Platform products)
* ..Orion Platform functions (DESCRIPTION: container for all Orion Platform specific functions)
* ....GetInstalledProducts.ps1 (DESCRIPTION: function for getting all installed products)
* ..Tools (DESCRIPTION: container for all tools composed from functions, data files and so on)
* ..FunctionTemplate.ps1 (DESCRIPTION: template for any new function)
* ..GetLatestRepository.ps1 (DESCRIPTION: script for downloading whole repository)  
* ..README.md (DESCRIPTION: this file)