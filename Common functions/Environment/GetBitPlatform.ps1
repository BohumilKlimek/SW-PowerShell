#region Function info
    ### PURPOSE:
        ### This function returns bit platform (32 bit versus 64 bit), when executed on any Microsoft operation system.

    ### INPUT:
        ### No input parameters.

    ### OUTPUT:
        ### String, which will contain information about bit platform: "64bit" vs "32bit".

    ### DEPENDENCIES:
        ### No dependencies.

        ### On this function depends: "GetInstalledProducts.ps1".

    ### KNOWN LIMITATION(S):
        ### No limitations.
#endregion

function GetBitPlatfrom ()
{ 
	if (((Get-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Session Manager\Environment\").PROCESSOR_ARCHITECTURE) -eq "AMD64")
	{
		[System.String] $BitPlatfrom = "64bit"
    }
   	elseif (((Get-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Session Manager\Environment\").PROCESSOR_ARCHITECTURE) -eq "x86")
    {
		[System.String] $BitPlatfrom = "32bit"
	}

    ### Returning function output:
        return $BitPlatfrom																			   
}