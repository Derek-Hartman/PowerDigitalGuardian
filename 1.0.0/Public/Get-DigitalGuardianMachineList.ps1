<#
.Synopsis
    Get List of Machine Groups in Digital Guardian

.EXAMPLE 
    Get-DigitalGuardianMachineList -Token "token"

.NOTES
    Modified by: Derek Hartman
    Date: 8/28/2023

#>
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Function Get-DigitalGuardianMachineList {
    [CmdletBinding()]
	
    param(
        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your Token.")]
        [string[]]$Token
    )
	
	$Uri = "https://accessgw-usw.msp.digitalguardian.com/rest/1.0/lists/machine_group"
	
    $Header = @{
        'accept'        = 'application/json';
        'Authorization' = "Bearer $($Token)";
    }

    $Response = Invoke-RestMethod -Uri $Uri -Method Get -Headers $Header
	Write-Output $Response
}