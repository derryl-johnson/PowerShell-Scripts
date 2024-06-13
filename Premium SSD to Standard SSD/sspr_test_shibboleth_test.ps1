#Connects PS session to subscription name 340604-313266-Identity & Automation Operations
Set-AzContext -subscription "697e3b15-da95-4101-a49d-198676e76111"

# Stop and deallocate the VM before changing the storage type
Stop-AzVM -ResourceGroupName shibboleth_test_RG -Name az7368lappt1 -Force
Stop-AzVM -ResourceGroupName sspr_test_RG -Name az7373lappt1 -Force

$AZdisks = Import-Csv -Path 'C:\Premium SSD to Standard SSD\disk_test.csv'
            
foreach ($AZdisk in $AZdisks)            
{            
    $diskname = $AZdisk.Name
    $resourcegroup = $AZdisk.RG
    $storageType = 'StandardSSD_LRS'
    
# Gather disk info
$disk = Get-AzDisk -DiskName $diskname -ResourceGroupName $resourcegroup
           
# Update the storage type
$disk.Sku = [Microsoft.Azure.Management.Compute.Models.DiskSku]::new($storageType)
$disk | Update-AzDisk

}

Start-AzVM -ResourceGroupName shibboleth_test_RG -Name az7368lappt1
Start-AzVM -ResourceGroupName sspr_test_RG -Name az7373lappt1 