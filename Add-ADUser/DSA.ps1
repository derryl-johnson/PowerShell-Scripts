$Users = Import-Csv -Path "C:\DSA.csv"            
foreach ($User in $Users)            
{            
    $Displayname = $User.'NetID' + "-admin"
    $UserFirstname = $User.'Firstname'            
    $UserLastname = $User.'Lastname'            
    $UPN = $Displayname  + "@uta.edu"
    $Password = $User.'Password'
    $HomePage = $User.'wWWHomePage'            
    New-ADUser -Name "$Displayname" -DisplayName "$Displayname" -SamAccountName "$Displayname" -UserPrincipalName $UPN -GivenName "$UserFirstname" -Surname "$UserLastname" -HomePage "$HomePage" -AccountPassword (ConvertTo-SecureString $Password -AsPlainText -Force) -Enabled $true -Path "OU=AdminAccounts,OU=VP for Information Technology,OU=President,OU=Departments,DC=uta,DC=edu" -ChangePasswordAtLogon $true
    Add-ADGroupMember -Identity OITAdmins-DSA -Members $Displayname
}