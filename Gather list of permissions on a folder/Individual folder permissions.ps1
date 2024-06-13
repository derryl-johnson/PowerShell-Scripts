$startingpath = "\\utafs02\york"

#Get-ChildItem -Directory $startingpath | Out-File 'C:\OITAdmins\Folder Permissions\dnuber.txt' -Append
$startingpath >> 'C:\OITAdmins\Folder Permissions\dnuber.txt'
(Get-Acl -Path $startingpath).Access | ft IdentityReference >> 'C:\OITAdmins\Folder Permissions\dnuber.txt' 