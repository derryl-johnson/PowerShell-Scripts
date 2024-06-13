$startingpath = "\\utafs02\uafs"
$Output = @() 
foreach ($folder in $(Get-ChildItem -Directory $startingpath)) { 
    $Acl = Get-Acl -Path $Folder.FullName 
    ForEach ($Access in $Acl.Access) { 
$Properties = [ordered]@{'Folder Name'=$Folder.FullName;'Group/User'=$Access.IdentityReference;'Permissions'=$Access.FileSystemRights;'Inherited'=$Access.IsInherited} 
$Output += New-Object -TypeName PSObject -Property $Properties 
    } 
} 
$Output | Export-Csv 'C:\OITAdmins\Folder Permissions\uafs.csv'