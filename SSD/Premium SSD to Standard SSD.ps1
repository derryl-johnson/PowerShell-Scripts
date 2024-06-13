$AZdisks = Import-Csv -Path 'C:\Premium SSD to Standard SSD\disk_test.csv'
            
foreach ($AZdisk in $AZdisks)            
{            
    $diskname = $AZdisk.Name
    $resourcegroup = $AZdisk.RG
    $storageType = 'Premium_LRS'
    $vmname = $AZdisk.owner

#Gather disk info
$disk = Get-AzDisk -DiskName $diskname -ResourceGroupName $resourcegroup


                
# Stop and deallocate the VM before changing the storage type
#Stop-AzVM $resourcegroup -Name $vmname -Force

# Update the storage type
$disk.Sku = [Microsoft.Azure.Management.Compute.Models.DiskSku]::new($storageType)
$disk | Update-AzDisk

#Start-AzVM -ResourceGroupName $resourcegroup -Name $vmname   

}

