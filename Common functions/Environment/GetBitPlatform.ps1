### Purpose of this function is to return bit platform (32 bit versus 64 bit) on Microsoft operation systems
    ### No input parameters
    ### Output: string, which will contain information about bit platform: "64bit" vs "32bit"

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

    return $BitPlatfrom																			   
} 