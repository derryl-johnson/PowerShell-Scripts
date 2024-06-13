$Folder = Get-ChildItem -Path C:\Web
foreach ($Folder in $Folder)            
{            
    Grant-smbShareAccess -name "$Folder" -AccountName "Derryljohnson\Domain Users" -AccessRight Full -force
    Revoke-smbshareaccess -name "$Folder" -AccountName "Everyone" -force 
    

    #This will give the Everyone group ful access again
    #Grant-smbShareAccess -name "$Folder" -AccountName "Everyone" -AccessRight Full -force Out-Null
    #Revoke-smbshareaccess -name "$Folder" -AccountName "Derryljohnson\Domain Users" -force Out-Null

}