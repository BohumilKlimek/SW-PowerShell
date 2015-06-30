#region Function info
    ### PURPOSE:
        ### This function extract zip file.

    ### INPUT:
        ### There are two mandatory input parameters:
            ### 1) String, which represent zip file location. Empty string is used as default value if not specified.
            ### 2) String, which represent where to extract zip file. Empty string is used as default value if not specified. 

    ### OUTPUT:
        ### String, which contains following values:
            ### 1) "ERROR: Zip file not found", in case zip file cannot be found in specified path.
            ### 2) "ERROR: First input parameter is missing", in case first input parameter is null or empty.
            ### 3) "ERROR: Second input parameter is missing", in case second input parameter is null or empty.
            ### 4) "Extraction finished", in case zip file was successfully extracted.

    ### DEPENDENCIES:
        ### There is dependency on "System.IO.Compression.FileSystem" assembly, which isn't loaded by default in PowerShell and needs to be loaded explicitly.

        ### On this function depends: "GetLatestRepository.ps1".

    ### KNOWN LIMITATION(S):
        ### There is no possibility to overwrite file(s) if there will be already any. If this happen "ExtractToDirectory" function will throw exception, which is not handled by "ExtractZipFile" function.
#endregion

function ExtractZipFile ([System.String] $ZipFileLocation = "", [System.String] $ExtractionDestination = "")
{ 
    ### Check for missing input parameters:
        if ([System.String]::IsNullOrEmpty($ZipFileLocation))
        {
            return [System.String] "ERROR: First input parameter is missing"
        }

        if ([System.String]::IsNullOrEmpty($ExtractionDestination))
        {
            return [System.String] "ERROR: Second input parameter is missing"
        }

    ### Check for correct value for location of the zip file:
        If (!(Test-Path $ZipFileLocation))
        {
            return [System.String] "ERROR: Zip file not found"
        }

	### Loading needed dependencies:
        [System.Reflection.Assembly]::LoadWithPartialName("System.IO.Compression.FileSystem") | Out-Null

    ### Main function logic - extracting zip file:
        [System.IO.Compression.Zipfile]::ExtractToDirectory($ZipFileLocation, $ExtractionDestination)

    return [System.String] "Extraction finished"
}