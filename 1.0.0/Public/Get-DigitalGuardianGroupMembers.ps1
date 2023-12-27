<#
.Synopsis
    Get List of Machine Groups in Digital Guardian

.EXAMPLE 
    Get-DigitalGuardianGroupMembers -Token "token" -ClientID "ID" -GroupName "Group"

.NOTES
    Modified by: Derek Hartman
    Date: 8/28/2023

#>
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Function Get-DigitalGuardianGroupMembers {
    [CmdletBinding()]
	
    param(
        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your Token.")]
        [string[]]$Token,

        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your Client ID.")]
        [string[]]$ClientID,

        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your Group Name.")]
        [string[]]$GroupName
    )
	
    $Header = @{
        'accept'        = 'application/json';
        'Authorization' = "Bearer $($Token)";
    }

    $ReplaceSpaces = $GroupName.Replace(' ','%20')
	
	$Uri = "https://accessgw-usw.msp.digitalguardian.com/rest/1.0/lists/$ClientID/group/values?group_name=$ReplaceSpaces&limit=2970"

    $Response = Invoke-RestMethod -Uri $Uri -Method Get -Headers $Header
	Write-Output $Response
}