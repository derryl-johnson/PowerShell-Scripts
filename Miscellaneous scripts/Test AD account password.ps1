﻿ #Import Active Directory Module 
 Import-Module Activedirectory 
 
 #Clear User Info Function 
    Function ClearUserInfo 
    { 
        $Cred = $Null 
        $DomainNetBIOS = $Null 
        $UserName  = $Null 
        $Password = $Null 
    } 
 
#Rerun The Script Function 
 Function Rerun 
    { 
        $Title = "Test Another Credentials?" 
        $Message = "Do you want to Test Another Credentials?" 
        $Yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", "Test Another Credentials." 
        $No = New-Object System.Management.Automation.Host.ChoiceDescription "&No", "End Script." 
        $Options = [System.Management.Automation.Host.ChoiceDescription[]]($Yes, $No) 
        $Result = $host.ui.PromptForChoice($Title, $Message, $Options, 0)  
 
        Switch ($Result) 
        { 
            0 {TestUserCredentials} 
            1 {"End Script."} 
        } 
    } 
 
#Test User Credentials Function 
Function TestUserCredentials 
{ 
    ClearUserInfo    
    #Get user credentials 
    $Cred = Get-Credential -Message "Enter Your Credentials (Domain\Username)" 
    if ($Cred -eq $Null) 
                        { 
                            Write-Host "Please enter your username in the form of Domain\UserName and try again" -BackgroundColor Black -ForegroundColor Yellow 
                            Rerun 
                            Break                           
                        } 
 
    #Parse provided user credentials 
    $DomainNetBIOS = $Cred.username.Split("{\}")[0] 
    $UserName = $Cred.username.Split("{\}")[1] 
    $Password = $Cred.GetNetworkCredential().password 
     
    Write-Host "`n" 
    Write-Host "Checking Credentials for $DomainNetBIOS\$UserName" -BackgroundColor Black -ForegroundColor White 
    Write-Host "***************************************" 
 
    If ($DomainNetBIOS -eq $Null -or $UserName -eq $Null)  
                        { 
                            Write-Host "Please enter your username in the form of Domain\UserName and try again" -BackgroundColor Black -ForegroundColor Yellow 
                            Rerun 
                            Break 
                        } 
    #    Checks if the domain in question is reachable, and get the domain FQDN. 
    Try 
    { 
        $DomainFQDN = (Get-ADDomain $DomainNetBIOS).DNSRoot 
    } 
    Catch 
    { 
        Write-Host "Error: Domain was not found: " $_.Exception.Message -BackgroundColor Black -ForegroundColor Red 
        Write-Host "Please make sure the domain NetBios name is correct, and is reachable from this computer" -BackgroundColor Black -ForegroundColor Red 
        Rerun 
        Break 
    } 
     
    #Checks user credentials against the domain 
    $DomainObj = "LDAP://" + $DomainFQDN 
    $DomainBind = New-Object System.DirectoryServices.DirectoryEntry($DomainObj,$UserName,$Password) 
    $DomainName = $DomainBind.distinguishedName 
     
    If ($DomainName -eq $Null) 
        { 
            Write-Host "Domain $DomainFQDN was found: True" -BackgroundColor Black -ForegroundColor Green 
         
            $UserExist = Get-ADUser -Server $DomainFQDN -Properties LockedOut -Filter {sAMAccountName -eq $UserName} 
            If ($UserExist -eq $Null)  
                        { 
                            Write-Host "Error: Username $Username does not exist in $DomainFQDN Domain." -BackgroundColor Black -ForegroundColor Red 
                            Rerun 
                            Break 
                        } 
            Else  
                        {    
                            Write-Host "User exists in the domain: True" -BackgroundColor Black -ForegroundColor Green 
 
 
                            If ($UserExist.Enabled -eq "True") 
                                    { 
                                        Write-Host "User Enabled: "$UserExist.Enabled -BackgroundColor Black -ForegroundColor Green 
                                    } 
 
                            Else 
                                    { 
                                        Write-Host "User Enabled: "$UserExist.Enabled -BackgroundColor Black -ForegroundColor RED 
                                        Write-Host "Enable the user account in Active Directory, Then check again" -BackgroundColor Black -ForegroundColor RED 
                                        Rerun 
                                        Break 
                                    } 
 
                            If ($UserExist.LockedOut -eq "True") 
                                    { 
                                        Write-Host "User Locked: " $UserExist.LockedOut -BackgroundColor Black -ForegroundColor Red 
                                        Write-Host "Unlock the User Account in Active Directory, Then check again..." -BackgroundColor Black -ForegroundColor RED 
                                        Rerun 
                                        Break 
                                    } 
                            Else 
                                    { 
                                        Write-Host "User Locked: " $UserExist.LockedOut -BackgroundColor Black -ForegroundColor Green 
                                    } 
                        } 
     
            Write-Host "Authentication failed for $DomainNetBIOS\$UserName with the provided password." -BackgroundColor Black -ForegroundColor Red 
            Write-Host "Please confirm the password, and try again..." -BackgroundColor Black -ForegroundColor Red 
            Rerun 
            Break 
        } 
      
    Else 
        { 
        Write-Host "SUCCESS: The account $Username successfully authenticated against the domain: $DomainFQDN" -BackgroundColor Black -ForegroundColor Green 
        Rerun 
        Break 
        } 
}     
 
TestUserCredentials 
ClearUserInfo  