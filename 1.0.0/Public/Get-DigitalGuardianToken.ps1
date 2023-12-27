<#
.Synopsis
    Uses client secret auth to generate bearer token.

.EXAMPLE 
    Get-DigitalGuardianToken -ClientID "ID" -ClientSecret "Secret"

.NOTES
    Modified by: Derek Hartman
    Date: 8/28/2023

#>
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Function Get-DigitalGuardianToken {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your Client ID.")]
        [string[]]$ClientID,

        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your Secret.")]
        [string[]]$ClientSecret
    )
	
	$Uri = "https://authsrv.msp.digitalguardian.com/as/token.oauth2"

    $Header = @{
        'Content-Type'  = 'application/x-www-form-urlencoded';
    }
    $Body = @{
        'client_id'     = "$ClientID";
        'client_secret' = "$ClientSecret";
        'grant_type'    = "client_credentials";
        'scope'         = "client";
    }

    $Response = Invoke-RestMethod -Uri $Uri -Method Post -Headers $Header -Body $Body
    Write-Output $Response
}