$Shares = Import-Csv -Path "C:\temp\planetariumfs.csv"            
foreach ($Shares in $Shares)            
{            
    $foldername = $Shares.'Name'
    $account = $Shares.'AccountName'
    $access = $Shares.'AccessRight'

    #This will revoke all permissions for all shared folders
    #Revoke-smbshareaccess -name "$foldername" -AccountName $account -force     
    
    #This will restore all permissions for all shared folders
    Grant-smbShareAccess -name "$foldername" -AccountName $account -AccessRight $access -force 

}