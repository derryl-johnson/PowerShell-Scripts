$startingpath = "E:\ofm\group\PDC DEPT\"
$full_right = "FullControl"
$group1 = "UTA\pp-pdc-full"
$group2 = "UTA\pp-jobs-full"
$inherit = [System.Security.AccessControl.InheritanceFlags]"ContainerInherit, ObjectInherit" #This applies the inheritance to the child folder from the parent folder
$propagation =  [System.Security.AccessControl.PropagationFlags]"InheritOnly" 
$rule1 = New-Object System.Security.AccessControl.FileSystemAccessRule($group1,$full_right,$inherit, $propagation,"Allow")
$rule2 = New-Object System.Security.AccessControl.FileSystemAccessRule($group2,$full_right,$inherit, $propagation,"Allow")

#This loop restores the broken inheritence of each "Floor Plans" folder
foreach ($parentfolder in $(Get-ChildItem -Directory $startingpath -Recurse -Filter "Floor Plans*"))
{
    $acl = Get-Acl $parentfolder.FullName
    $acl.SetAccessRuleProtection($false,$true)
    Set-Acl $parentfolder.FullName $acl
}

#This resets the permissions
Get-ChildItem -Directory $startingpath
$acl = Get-Acl $folder.FullName
$acl.SetAccessRule($rule1)
$acl.RemoveAccessRule($rule2)
Set-Acl $folder.FullName $acl

#This command verifies that the Jobs folder is inherting from the PDC folder
(Get-Acl -Path "C:\PDC\Jobs").Access | ft IdentityReference,IsInherited
