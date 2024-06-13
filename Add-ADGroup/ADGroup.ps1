Import-Module ActiveDirectory 


#This command will add multiple users to an AD group
Import-Csv -Path “C:\Users\johnsond3-admin\Documents\Powershell\SASMetadataUsers_test.csv” | ForEach-Object {Add-ADGroupMember -Identity “SASUsers” -Members $_.’UTANetID’}


#This command will remove multple users from an AD group
#Import-Csv -Path “C:\Users\johnsond3-admin\Documents\Powershell\SASMetadataUsers_test.csv” | ForEach-Object {Remove-ADGroupMember -Identity “SASUsers” -Members $_.’UTANetID’ -Confirm:$false}