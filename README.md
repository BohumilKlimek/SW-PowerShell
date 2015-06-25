### SW-PowerShell
* This is the main repository for all PowerShell scripts with any relation to SolarWinds.

### How to download whole repository to your system?
* Just execute "GetLatestRepository.ps1" stored in root of this repository.

### Action items
* Replace GetLatestRepository.ps1 approach with downloading repository in zip file and extracting it to some location.
* ..Consider deleting old repository if it will exist.
* Add function for detecting correct version of PowerShell (script execution will be blocked, if lover than 4.0).

### Long term ideas
* Create function, which will detect .NET version.

### Content structure + plain description
* SW-PowerShell  
* ..Common functions (DESCRIPTION: logical container)
* ....Environment (DESCRIPTION: logical container)
* ......GetBitPlatform.ps1 (DESCRIPTION: function for distinguishing between 32 and 64 platforms)
* ....Zip (DESCRIPTION: logical container)
* ......ExtractZipFile.ps1 (DESCRIPTION: function for extracting zip files)
* ..FunctionTemplate.ps1 (DESCRIPTION: template for any new function)
* ..GetLatestRepository.ps1 (DESCRIPTION: script for downloading whole repository)  
* ..README.md (DESCRIPTION: this file)