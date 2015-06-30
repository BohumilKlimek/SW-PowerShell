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