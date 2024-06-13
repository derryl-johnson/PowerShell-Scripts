$startingpath = "E:\ofm\group\PDC DEPT\JOBS\*"
$full_right = "FullControl"
$read_right = "Read"
$group1 = "UTA\pp-pdc-full"
$group2 = "UTA\pp-jobs-full"
$inherit = [System.Security.AccessControl.InheritanceFlags]"ContainerInherit, ObjectInherit" #This applies the inheritance to the child folder from the parent folder
$propagation =  [System.Security.AccessControl.PropagationFlags]"None" <#When using the InheritanceFlags property, you must also use the PropagationFlags. The value "None" means this property is not being used.#>
$rule1 = New-Object System.Security.AccessControl.FileSystemAccessRule($group1,$read_right,$inherit, $propagation,"Allow")
$rule2 = New-Object System.Security.AccessControl.FileSystemAccessRule($group1,$full_right,$inherit, $propagation,"Allow")
$rule3 = New-Object System.Security.AccessControl.FileSystemAccessRule($group2,$full_right,$inherit, $propagation,"Allow")



#This loop breaks the inheritence of each folder
foreach ($parentfolder in $(Get-ChildItem -Directory $startingpath -Recurse -Filter "Floor Plans*"))
{
    $acl = Get-Acl $parentfolder.FullName
    $acl.SetAccessRuleProtection($true,$true)
    Set-Acl $parentfolder.FullName $acl
}
 
#This loop sets the permissions for each folder
foreach ($folder in $(Get-ChildItem -Directory $startingpath -Recurse -Filter "Floor Plans*"))
{
    $acl = Get-Acl $folder.FullName
    $acl.RemoveAccessRule($rule2)
    $acl.SetAccessRule($rule1)
    $acl.SetAccessRule($rule3)
    Set-Acl $folder.FullName $acl
}

Clear-Host 



