#Start logging
Start-transcript 'C:\Premium SSD to Standard SSD\log.txt'

#Connects PS session to subscription name 340604-310660-Enterprise Development Admin
Set-AzContext -subscription "3a4efad0-4000-4cd7-a775-ab814ec17430"

# Stop and deallocate the VM before changing the storage type
Stop-AzVM -ResourceGroupName aceweb_test_RG -Name ace-dedwapt01 -Force

$AZdisks = Import-Csv -Path 'C:\Premium SSD to Standard SSD\340604-310660-Enterprise Development Admin_test.csv'
            
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

Start-AzVM -ResourceGroupName aceweb_test_RG -Name ace-dedwapt01


#Connects PS session to subscription name 340604-560007-Ryan CTR for Urban Land Util
Set-AzContext -subscription "65e940f4-5640-4142-bfec-f47a953ac9ce"

# Stop and deallocate the VM before changing the storage type
Stop-AzVM -ResourceGroupName argus_test_RG -Name argusdapptst -Force

$AZdisks = Import-Csv -Path 'C:\Premium SSD to Standard SSD\340604-560007-Ryan CTR for Urban Land Util_test.csv'
            
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

Start-AzVM -ResourceGroupName argus_test_RG -Name argusdapptst

# Stop logging
Stop-transcript