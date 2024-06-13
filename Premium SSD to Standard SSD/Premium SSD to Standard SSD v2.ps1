#Start logging
Start-transcript 'C:\Premium SSD to Standard SSD\log.txt'

##### Connects PS session to subscription name 340502-313273-OIT Enterprise Data Services
Set-AzContext -subscription "a2600b75-bb30-4c7c-9f23-4ebb73b96ef2"

# Stop and deallocate the VM before changing the storage type
Stop-AzVM -ResourceGroupName datafactory_RG -Name az6461wappp1 -Force -Verbose -NoWait -NoWait

# Import the CSV into a variable
$AZdisks = Import-Csv -Path 'C:\Premium SSD to Standard SSD\340502-313273-OIT Enterprise Data Services.csv'
            
foreach ($AZdisk in $AZdisks)            
{   
    # Imports the data from the CSV in each row into a variable         
    $diskname = $AZdisk.Name
    $resourcegroup = $AZdisk.RG
    $storageType = 'StandardSSD_LRS'
    
    # Gather disk info
    $disk = Get-AzDisk -DiskName $diskname -ResourceGroupName $resourcegroup
           
    # Update the storage type
    $disk.Sku = [Microsoft.Azure.Management.Compute.Models.DiskSku]::new($storageType)
    $disk | Update-AzDisk
    Write-Output "The disk '$diskname' has been converted successfully." `n
}

Start-AzVM -ResourceGroupName datafactory_RG -Name az6461wappp1 -Verbose -NoWait


##### Connects PS session to subscription name 340604-313266-Identity & Automation Operations
Set-AzContext -subscription "697e3b15-da95-4101-a49d-198676e76111"

# Stop and deallocate the VM before changing the storage type
Stop-AzVM -ResourceGroupName azureadconnect_RG -Name az617Awappp1 -Force -Verbose -NoWait -NoWait
Stop-AzVM -ResourceGroupName identitygovernance_RG -Name az6964lappp1 -Force -Verbose -NoWait -NoWait
Stop-AzVM -ResourceGroupName identitygovernance_RG -Name az6964ldbp1 -Force -Verbose -NoWait -NoWait
Stop-AzVM -ResourceGroupName igel_RG -Name az6967wappp1 -Force -Verbose -NoWait -NoWait
Stop-AzVM -ResourceGroupName shibboleth_RG -Name az7368lappp1 -Force -Verbose -NoWait -NoWait
Stop-AzVM -ResourceGroupName shibboleth_RG -Name az7368lappp2 -Force -Verbose -NoWait -NoWait
Stop-AzVM -ResourceGroupName sspr_RG -Name az7373lappp1 -Force -Verbose -NoWait -NoWait
Stop-AzVM -ResourceGroupName sspr_RG -Name az7373lappp2 -Force -Verbose -NoWait -NoWait
Stop-AzVM -ResourceGroupName sspr_RG -Name az7373lappp3 -Force -Verbose -NoWait -NoWait
Stop-AzVM -ResourceGroupName UTArlingtonAutomation-OrchestrationRG -Name azhwwapp02 -Force -Verbose -NoWait -NoWait
Stop-AzVM -ResourceGroupName active-directory_RG -Name azwipamdb01 -Force -Verbose -NoWait -NoWait

# Import the CSV into a variable
$AZdisks = Import-Csv -Path 'C:\Premium SSD to Standard SSD\340604-313266-Identity & Automation Operations.csv'
            
foreach ($AZdisk in $AZdisks)            
{   
    # Imports the data from the CSV in each row into a variable         
    $diskname = $AZdisk.Name
    $resourcegroup = $AZdisk.RG
    $storageType = 'StandardSSD_LRS'
    
    # Gather disk info
    $disk = Get-AzDisk -DiskName $diskname -ResourceGroupName $resourcegroup
           
    # Update the storage type
    $disk.Sku = [Microsoft.Azure.Management.Compute.Models.DiskSku]::new($storageType)
    $disk | Update-AzDisk
    Write-Output "The disk '$diskname' has been converted successfully." `n
}

Start-AzVM -ResourceGroupName azureadconnect_RG -Name az617Awappp1 -Verbose -NoWait -NoWait
Start-AzVM -ResourceGroupName identitygovernance_RG -Name az6964lappp1 -Verbose -NoWait -NoWait
Start-AzVM -ResourceGroupName identitygovernance_RG -Name az6964ldbp1 -Verbose -NoWait -NoWait
Start-AzVM -ResourceGroupName igel_RG -Name az6967wappp1 -Verbose -NoWait -NoWait
Start-AzVM -ResourceGroupName shibboleth_RG -Name az7368lappp1 -Verbose -NoWait -NoWait
Start-AzVM -ResourceGroupName shibboleth_RG -Name az7368lappp2 -Verbose -NoWait -NoWait
Start-AzVM -ResourceGroupName sspr_RG -Name az7373lappp1 -Verbose -NoWait -NoWait
Start-AzVM -ResourceGroupName sspr_RG -Name az7373lappp2 -Verbose -NoWait -NoWait
Start-AzVM -ResourceGroupName sspr_RG -Name az7373lappp3 -Verbose -NoWait -NoWait
Start-AzVM -ResourceGroupName UTArlingtonAutomation-OrchestrationRG -Name azhwwapp02 -Verbose -NoWait -NoWait
Start-AzVM -ResourceGroupName active-directory_RG -Name azwipamdb01 -Verbose -NoWait -NoWait 


##### Connects PS session to subscription name 340604-200095-Physics
Set-AzContext -subscription "9da9927d-c887-4203-9ee7-9f9f3f9564b7"

# Stop and deallocate the VM before changing the storage type
Stop-AzVM -ResourceGroupName pbhz_RG -Name az7062lwebp1 -Force -Verbose -NoWait -NoWait

# Import the CSV into a variable
$AZdisks = Import-Csv -Path 'C:\Premium SSD to Standard SSD\340604-200095-Physics.csv'
            
foreach ($AZdisk in $AZdisks)            
{   
    # Imports the data from the CSV in each row into a variable         
    $diskname = $AZdisk.Name
    $resourcegroup = $AZdisk.RG
    $storageType = 'StandardSSD_LRS'
    
    # Gather disk info
    $disk = Get-AzDisk -DiskName $diskname -ResourceGroupName $resourcegroup
           
    # Update the storage type
    $disk.Sku = [Microsoft.Azure.Management.Compute.Models.DiskSku]::new($storageType)
    $disk | Update-AzDisk
    Write-Output "The disk '$diskname' has been converted successfully." `n
}

Start-AzVM -ResourceGroupName pbhz_RG -Name az7062lwebp1 -Verbose -NoWait -NoWait 


##### Connects PS session to subscription name 340604-200169-Nanofab Laboratory
Set-AzContext -subscription "f9a21f82-95ab-4f36-89d2-7d8b8ed03e33"

# Stop and deallocate the VM before changing the storage type
Stop-AzVM -ResourceGroupName nuclearresearch_RG -Name az6E75lappp1 -Force -Verbose -NoWait -NoWait
Stop-AzVM -ResourceGroupName nuclearresearch_development_RG -Name az6E75lappd1 -Force -Verbose -NoWait -NoWait

# Import the CSV into a variable
$AZdisks = Import-Csv -Path 'C:\Premium SSD to Standard SSD\340604-200169-Nanofab Laboratory.csv'
            
foreach ($AZdisk in $AZdisks)            
{   
    # Imports the data from the CSV in each row into a variable         
    $diskname = $AZdisk.Name
    $resourcegroup = $AZdisk.RG
    $storageType = 'StandardSSD_LRS'
    
    # Gather disk info
    $disk = Get-AzDisk -DiskName $diskname -ResourceGroupName $resourcegroup
           
    # Update the storage type
    $disk.Sku = [Microsoft.Azure.Management.Compute.Models.DiskSku]::new($storageType)
    $disk | Update-AzDisk
    Write-Output "The disk '$diskname' has been converted successfully." `n
}

Start-AzVM -ResourceGroupName nuclearresearch_RG -Name az6E75lappp1 -Verbose -NoWait -NoWait
Start-AzVM -ResourceGroupName nuclearresearch_development_RG -Name az6E75lappd1 -Verbose -NoWait -NoWait


##### Connects PS session to subscription name 340604-310065-VP For Research-Operations
Set-AzContext -subscription "80bd6696-5331-4add-80f6-1b74412975a9"

# Stop and deallocate the VM before changing the storage type
Stop-AzVM -ResourceGroupName research_RG -Name az7265lwebp1 -Force -Verbose -NoWait -NoWait
Stop-AzVM -ResourceGroupName vicepresidentresearch_RG -Name az7669lappp1 -Force -Verbose -NoWait -NoWait

# Import the CSV into a variable
$AZdisks = Import-Csv -Path 'C:\Premium SSD to Standard SSD\340604-200169-Nanofab Laboratory.csv'
            
foreach ($AZdisk in $AZdisks)            
{   
    # Imports the data from the CSV in each row into a variable         
    $diskname = $AZdisk.Name
    $resourcegroup = $AZdisk.RG
    $storageType = 'StandardSSD_LRS'
    
    # Gather disk info
    $disk = Get-AzDisk -DiskName $diskname -ResourceGroupName $resourcegroup
           
    # Update the storage type
    $disk.Sku = [Microsoft.Azure.Management.Compute.Models.DiskSku]::new($storageType)
    $disk | Update-AzDisk
    Write-Output "The disk '$diskname' has been converted successfully." `n
}

Start-AzVM -ResourceGroupName research_RG -Name az7265lwebp1 -Verbose -NoWait -NoWait
Start-AzVM -ResourceGroupName vicepresidentresearch_RG -Name az7669lappp1 -Verbose -NoWait -NoWait


##### Connects PS session to subscription name 340604-310433-Planetarium
Set-AzContext -subscription "610c9e5b-c609-4943-b968-ddf3a3bc3222"

# Stop and deallocate the VM before changing the storage type
Stop-AzVM -ResourceGroupName render_RG -Name az7265wagtp10 -Force -Verbose -NoWait -NoWait
Stop-AzVM -ResourceGroupName render_RG -Name az7265wagtp11 -Force -Verbose -NoWait -NoWait
Stop-AzVM -ResourceGroupName render_RG -Name az7265wagtp12 -Force -Verbose -NoWait -NoWait
Stop-AzVM -ResourceGroupName render_RG -Name az7265wagtp13 -Force -Verbose -NoWait -NoWait
Stop-AzVM -ResourceGroupName render_RG -Name az7265wagtp14 -Force -Verbose -NoWait -NoWait
Stop-AzVM -ResourceGroupName render_RG -Name az7265wagtp15 -Force -Verbose -NoWait -NoWait
Stop-AzVM -ResourceGroupName render_RG -Name az7265wagtp16 -Force -Verbose -NoWait -NoWait
Stop-AzVM -ResourceGroupName render_RG -Name az7265wagtp1 -Force -Verbose -NoWait -NoWait
Stop-AzVM -ResourceGroupName render_RG -Name az7265wagtp2 -Force -Verbose -NoWait -NoWait
Stop-AzVM -ResourceGroupName render_RG -Name az7265wagtp3 -Force -Verbose -NoWait -NoWait
Stop-AzVM -ResourceGroupName render_RG -Name az7265wagtp4 -Force -Verbose -NoWait -NoWait
Stop-AzVM -ResourceGroupName render_RG -Name az7265wagtp5 -Force -Verbose -NoWait -NoWait
Stop-AzVM -ResourceGroupName render_RG -Name az7265wagtp6 -Force -Verbose -NoWait -NoWait
Stop-AzVM -ResourceGroupName render_RG -Name az7265wagtp7 -Force -Verbose -NoWait -NoWait 
Stop-AzVM -ResourceGroupName render_RG -Name az7265wagtp8 -Force -Verbose -NoWait -NoWait
Stop-AzVM -ResourceGroupName render_RG -Name az7265wagtp9 -Force -Verbose -NoWait -NoWait
Stop-AzVM -ResourceGroupName render_RG -Name az7265wappp1 -Force -Verbose -NoWait -NoWait

# Import the CSV into a variable
$AZdisks = Import-Csv -Path 'C:\Premium SSD to Standard SSD\340604-310433-Planetarium.csv'
            
foreach ($AZdisk in $AZdisks)            
{   
    # Imports the data from the CSV in each row into a variable         
    $diskname = $AZdisk.Name
    $resourcegroup = $AZdisk.RG
    $storageType = 'StandardSSD_LRS'
    
    # Gather disk info
    $disk = Get-AzDisk -DiskName $diskname -ResourceGroupName $resourcegroup
           
    # Update the storage type
    $disk.Sku = [Microsoft.Azure.Management.Compute.Models.DiskSku]::new($storageType)
    $disk | Update-AzDisk
    Write-Output "The disk '$diskname' has been converted successfully." `n
}

Start-AzVm -ResourceGroupName render_RG -Name az7265wagtp10 -Verbose -NoWait -NoWait 
Start-AzVm -ResourceGroupName render_RG -Name az7265wagtp11 -Verbose -NoWait -NoWait 
Start-AzVm -ResourceGroupName render_RG -Name az7265wagtp12 -Verbose -NoWait -NoWait 
Start-AzVm -ResourceGroupName render_RG -Name az7265wagtp13 -Verbose -NoWait -NoWait 
Start-AzVm -ResourceGroupName render_RG -Name az7265wagtp14 -Verbose -NoWait -NoWait 
Start-AzVm -ResourceGroupName render_RG -Name az7265wagtp15 -Verbose -NoWait -NoWait 
Start-AzVm -ResourceGroupName render_RG -Name az7265wagtp16 -Verbose -NoWait -NoWait 
Start-AzVm -ResourceGroupName render_RG -Name az7265wagtp1 -Verbose -NoWait -NoWait 
Start-AzVm -ResourceGroupName render_RG -Name az7265wagtp2 -Verbose -NoWait -NoWait 
Start-AzVm -ResourceGroupName render_RG -Name az7265wagtp3 -Verbose -NoWait -NoWait 
Start-AzVm -ResourceGroupName render_RG -Name az7265wagtp4 -Verbose -NoWait -NoWait 
Start-AzVm -ResourceGroupName render_RG -Name az7265wagtp5 -Verbose -NoWait -NoWait 
Start-AzVm -ResourceGroupName render_RG -Name az7265wagtp6 -Verbose -NoWait -NoWait 
Start-AzVm -ResourceGroupName render_RG -Name az7265wagtp7 -Verbose -NoWait -NoWait 
Start-AzVm -ResourceGroupName render_RG -Name az7265wagtp8 -Verbose -NoWait -NoWait 
Start-AzVm -ResourceGroupName render_RG -Name az7265wagtp9 -Verbose -NoWait -NoWait 
Start-AzVm -ResourceGroupName render_RG -Name az7265wappp1 -Verbose -NoWait -NoWait 


##### Connects PS session to subscription name 340604-310521-Computer Science & Engineering
Set-AzContext -subscription "9d942574-178f-4706-9a27-c160b13148b2"

# Stop and deallocate the VM before changing the storage type
Stop-AzVM -ResourceGroupName cseweb_RG -Name az6373lwebp1 -Force -Verbose -NoWait -NoWait
Stop-AzVM -ResourceGroupName cseweb_RG -Name az6373lwebp2 -Force -Verbose -NoWait -NoWait
Stop-AzVM -ResourceGroupName cseweb_test_RG -Name az6373lwebt1 -Force -Verbose -NoWait -NoWait

# Import the CSV into a variable
$AZdisks = Import-Csv -Path 'C:\Premium SSD to Standard SSD\340604-310521-Computer Science & Engineering.csv'
            
foreach ($AZdisk in $AZdisks)            
{   
    # Imports the data from the CSV in each row into a variable         
    $diskname = $AZdisk.Name
    $resourcegroup = $AZdisk.RG
    $storageType = 'StandardSSD_LRS'
    
    # Gather disk info
    $disk = Get-AzDisk -DiskName $diskname -ResourceGroupName $resourcegroup
           
    # Update the storage type
    $disk.Sku = [Microsoft.Azure.Management.Compute.Models.DiskSku]::new($storageType)
    $disk | Update-AzDisk
    Write-Output "The disk '$diskname' has been converted successfully." `n
}

Start-AzVM -ResourceGroupName cseweb_RG -Name az6373lwebp1 -Verbose -NoWait -NoWait
Start-AzVM -ResourceGroupName cseweb_RG -Name az6373lwebp2 -Verbose -NoWait -NoWait
Start-AzVM -ResourceGroupName cseweb_test_RG -Name az6373lwebt1 -Verbose -NoWait -NoWait


##### Connects PS session to subscription name 340604-311339-IDC CSE Makedon
Set-AzContext -subscription "0d22aed0-6d78-493b-b07b-b9e4eaa50b61"

# Stop and deallocate the VM before changing the storage type
Stop-AzVM -ResourceGroupName heracleiaweb_RG -Name az6865lwebp1 -Force -Verbose -NoWait -NoWait

# Import the CSV into a variable
$AZdisks = Import-Csv -Path 'C:\Premium SSD to Standard SSD\340604-311339-IDC CSE Makedon.csv'
            
foreach ($AZdisk in $AZdisks)            
{   
    # Imports the data from the CSV in each row into a variable         
    $diskname = $AZdisk.Name
    $resourcegroup = $AZdisk.RG
    $storageType = 'StandardSSD_LRS'
    
    # Gather disk info
    $disk = Get-AzDisk -DiskName $diskname -ResourceGroupName $resourcegroup
           
    # Update the storage type
    $disk.Sku = [Microsoft.Azure.Management.Compute.Models.DiskSku]::new($storageType)
    $disk | Update-AzDisk
    Write-Output "The disk '$diskname' has been converted successfully." `n
}

Start-AzVM -ResourceGroupName heracleiaweb_RG -Name az6865lwebp1 -Verbose -NoWait -NoWait


##### Connects PS session to subscription name 340604-311653-Office of Legal Affairs
Set-AzContext -subscription "445c25ef-4827-4472-a3fe-a270b476e2f8"

# Stop and deallocate the VM before changing the storage type
Stop-AzVM -ResourceGroupName legalfiles_RG -Name az6C65wdbp1 -Force -Verbose -NoWait -NoWait
Stop-AzVM -ResourceGroupName legalfiles_RG -Name az6C65wwebp1 -Force -Verbose -NoWait -NoWait

# Import the CSV into a variable
$AZdisks = Import-Csv -Path 'C:\Premium SSD to Standard SSD\340604-311653-Office of Legal Affairs.csv'
            
foreach ($AZdisk in $AZdisks)            
{   
    # Imports the data from the CSV in each row into a variable         
    $diskname = $AZdisk.Name
    $resourcegroup = $AZdisk.RG
    $storageType = 'StandardSSD_LRS'
    
    # Gather disk info
    $disk = Get-AzDisk -DiskName $diskname -ResourceGroupName $resourcegroup
           
    # Update the storage type
    $disk.Sku = [Microsoft.Azure.Management.Compute.Models.DiskSku]::new($storageType)
    $disk | Update-AzDisk
    Write-Output "The disk '$diskname' has been converted successfully." `n
}

Start-AzVM -ResourceGroupName legalfiles_RG -Name az6C65wdbp1 -Verbose -NoWait -NoWait
Start-AzVM -ResourceGroupName legalfiles_RG -Name az6C65wwebp1 -Verbose -NoWait -NoWait


##### Connects PS session to subscription name 340604-313250-OIT Instructional Tech Services
Set-AzContext -subscription "b9db2877-c7a3-4d69-ae3a-8172fd147d59"

# Stop and deallocate the VM before changing the storage type
Stop-AzVM -ResourceGroupName deepfreeze_RG -Name az6465wappp1 -Force -Verbose -NoWait -NoWait

# Import the CSV into a variable
$AZdisks = Import-Csv -Path 'C:\Premium SSD to Standard SSD\340604-313250-OIT Instructional Tech Services.csv'
            
foreach ($AZdisk in $AZdisks)            
{   
    # Imports the data from the CSV in each row into a variable         
    $diskname = $AZdisk.Name
    $resourcegroup = $AZdisk.RG
    $storageType = 'StandardSSD_LRS'
    
    # Gather disk info
    $disk = Get-AzDisk -DiskName $diskname -ResourceGroupName $resourcegroup
           
    # Update the storage type
    $disk.Sku = [Microsoft.Azure.Management.Compute.Models.DiskSku]::new($storageType)
    $disk | Update-AzDisk
    Write-Output "The disk '$diskname' has been converted successfully." `n
}

Start-AzVM -ResourceGroupName deepfreeze_RG -Name az6465wappp1 -Verbose -NoWait


##### Connects PS session to subscription name 340604-313250-OIT WVD
Set-AzContext -subscription "56c251cc-2acd-414a-822c-98b2b418db48"

# Stop and deallocate the VM before changing the storage type
Stop-AzVM -ResourceGroupName mysqlacademic_RG -Name az6D79ldbp1 -Force -Verbose -NoWait
Stop-AzVM -ResourceGroupName omega_RG -Name az6F6Dlappp1 -Force -Verbose -NoWait
Stop-AzVM -ResourceGroupName oracleacademic_RG -Name az6F72ldbp1 -Force -Verbose -NoWait

# Import the CSV into a variable
$AZdisks = Import-Csv -Path 'C:\Premium SSD to Standard SSD\340604-313250-OIT WVD.csv'
            
foreach ($AZdisk in $AZdisks)            
{   
    # Imports the data from the CSV in each row into a variable         
    $diskname = $AZdisk.Name
    $resourcegroup = $AZdisk.RG
    $storageType = 'StandardSSD_LRS'
    
    # Gather disk info
    $disk = Get-AzDisk -DiskName $diskname -ResourceGroupName $resourcegroup
           
    # Update the storage type
    $disk.Sku = [Microsoft.Azure.Management.Compute.Models.DiskSku]::new($storageType)
    $disk | Update-AzDisk
    Write-Output "The disk '$diskname' has been converted successfully." `n
}

Start-AzVM -ResourceGroupName mysqlacademic_RG -Name az6D79ldbp1 -Verbose -NoWait
Start-AzVM -ResourceGroupName omega_RG -Name az6F6Dlappp1 -Verbose -NoWait
Start-AzVM -ResourceGroupName oracleacademic_RG -Name az6F72ldbp1 -Verbose -NoWait


##### Connects PS session to subscription name 340604-313257-OIT Enterprise App Support
Set-AzContext -subscription "d38760ba-f565-4472-98a5-e41d8831d24d"

# Stop and deallocate the VM before changing the storage type
Stop-AzVM -ResourceGroupName chemenvmgmtsys_test_RG -Name az6368lwebt1 -Force -Verbose -NoWait
Stop-AzVM -ResourceGroupName exchange_RG -Name az6578wappp1 -Force -Verbose -NoWait
Stop-AzVM -ResourceGroupName licenseservers_RG -Name az6C69lappp1 -Force -Verbose -NoWait
Stop-AzVM -ResourceGroupName licenseservers_RG -Name az6C69wappp11 -Force -Verbose -NoWait
Stop-AzVM -ResourceGroupName licenseservers_RG -Name az6C69wappp13 -Force -Verbose -NoWait
Stop-AzVM -ResourceGroupName licenseservers_RG -Name az6C69wappp14 -Force -Verbose -NoWait
Stop-AzVM -ResourceGroupName licenseservers_RG -Name az6C69wappp16 -Force -Verbose -NoWait
Stop-AzVM -ResourceGroupName licenseservers_RG -Name az6C69wappp17 -Force -Verbose -NoWait
Stop-AzVM -ResourceGroupName licenseservers_RG -Name az6C69lappp1 -Force -Verbose -NoWait
Stop-AzVM -ResourceGroupName licenseservers_RG -Name az6C69wappp20 -Force -Verbose -NoWait
Stop-AzVM -ResourceGroupName licenseservers_RG -Name az6C69wappp22 -Force -Verbose -NoWait
Stop-AzVM -ResourceGroupName licenseservers_RG -Name az6C69wappp24 -Force -Verbose -NoWait
Stop-AzVM -ResourceGroupName licenseservers_RG -Name az6C69wappp25 -Force -Verbose -NoWait
Stop-AzVM -ResourceGroupName licenseservers_RG -Name az6C69wappp26 -Force -Verbose -NoWait
Stop-AzVM -ResourceGroupName licenseservers_RG -Name az6C69wappp28 -Force -Verbose -NoWait
Stop-AzVM -ResourceGroupName licenseservers_RG -Name az6C69wappp2 -Force -Verbose -NoWait
Stop-AzVM -ResourceGroupName licenseservers_RG -Name az6C69wappp30 -Force -Verbose -NoWait
Stop-AzVM -ResourceGroupName licenseservers_RG -Name az6C69wappp32 -Force -Verbose -NoWait
Stop-AzVM -ResourceGroupName licenseservers_RG -Name az6C69wappp33 -Force -Verbose -NoWait
Stop-AzVM -ResourceGroupName licenseservers_RG -Name az6C69wappp35 -Force -Verbose -NoWait
Stop-AzVM -ResourceGroupName licenseservers_RG -Name az6C69wappp3 -Force -Verbose -NoWait
Stop-AzVM -ResourceGroupName licenseservers_RG -Name az6C69wappp4 -Force -Verbose -NoWait
Stop-AzVM -ResourceGroupName licenseservers_RG -Name az6C69wappp5 -Force -Verbose -NoWait
Stop-AzVM -ResourceGroupName licenseservers_RG -Name az6C69wappp6 -Force -Verbose -NoWait
Stop-AzVM -ResourceGroupName licenseservers_RG -Name az6C69wappp8 -Force -Verbose -NoWait
Stop-AzVM -ResourceGroupName licenseservers_RG -Name az6C69wappp9 -Force -Verbose -NoWait

# Import the CSV into a variable
$AZdisks = Import-Csv -Path 'C:\Premium SSD to Standard SSD\340604-313257-OIT Enterprise App Support.csv'
            
foreach ($AZdisk in $AZdisks)            
{   
    # Imports the data from the CSV in each row into a variable         
    $diskname = $AZdisk.Name
    $resourcegroup = $AZdisk.RG
    $storageType = 'StandardSSD_LRS'
    
    # Gather disk info
    $disk = Get-AzDisk -DiskName $diskname -ResourceGroupName $resourcegroup
           
    # Update the storage type
    $disk.Sku = [Microsoft.Azure.Management.Compute.Models.DiskSku]::new($storageType)
    $disk | Update-AzDisk
    Write-Output "The disk '$diskname' has been converted successfully." `n
}

Start-AzVm -ResourceGroupName chemenvmgmtsys_test_RG -Name az6368lwebt1 -Verbose -NoWait
Start-AzVm -ResourceGroupName exchange_RG -Name az6578wappp1 -Verbose -NoWait 
Start-AzVm -ResourceGroupName licenseservers_RG -Name az6C69lappp1 -Verbose -NoWait 
Start-AzVm -ResourceGroupName licenseservers_RG -Name az6C69wappp11 -Verbose -NoWait
Start-AzVm -ResourceGroupName licenseservers_RG -Name az6C69wappp13 -Verbose -NoWait
Start-AzVm -ResourceGroupName licenseservers_RG -Name az6C69wappp14 -Verbose -NoWait
Start-AzVm -ResourceGroupName licenseservers_RG -Name az6C69wappp16 -Verbose -NoWait
Start-AzVm -ResourceGroupName licenseservers_RG -Name az6C69wappp17 -Verbose -NoWait
Start-AzVm -ResourceGroupName licenseservers_RG -Name az6C69lappp1 -Verbose -NoWait 
Start-AzVm -ResourceGroupName licenseservers_RG -Name az6C69wappp20 -Verbose -NoWait
Start-AzVm -ResourceGroupName licenseservers_RG -Name az6C69wappp22 -Verbose -NoWait
Start-AzVm -ResourceGroupName licenseservers_RG -Name az6C69wappp24 -Verbose -NoWait
Start-AzVm -ResourceGroupName licenseservers_RG -Name az6C69wappp25 -Verbose -NoWait
Start-AzVm -ResourceGroupName licenseservers_RG -Name az6C69wappp26 -Verbose -NoWait
Start-AzVm -ResourceGroupName licenseservers_RG -Name az6C69wappp28 -Verbose -NoWait
Start-AzVm -ResourceGroupName licenseservers_RG -Name az6C69wappp2 -Verbose -NoWait 
Start-AzVm -ResourceGroupName licenseservers_RG -Name az6C69wappp30 -Verbose -NoWait
Start-AzVm -ResourceGroupName licenseservers_RG -Name az6C69wappp32 -Verbose -NoWait
Start-AzVm -ResourceGroupName licenseservers_RG -Name az6C69wappp33 -Verbose -NoWait
Start-AzVm -ResourceGroupName licenseservers_RG -Name az6C69wappp35 -Verbose -NoWait
Start-AzVm -ResourceGroupName licenseservers_RG -Name az6C69wappp3 -Verbose -NoWait 
Start-AzVm -ResourceGroupName licenseservers_RG -Name az6C69wappp4 -Verbose -NoWait 
Start-AzVm -ResourceGroupName licenseservers_RG -Name az6C69wappp5 -Verbose -NoWait 
Start-AzVm -ResourceGroupName licenseservers_RG -Name az6C69wappp6 -Verbose -NoWait 
Start-AzVm -ResourceGroupName licenseservers_RG -Name az6C69wappp8 -Verbose -NoWait 
Start-AzVm -ResourceGroupName licenseservers_RG -Name az6C69wappp9 -Verbose -NoWait 


##### Connects PS session to subscription name 340604-313265-OIT Network Infrastructure
Set-AzContext -subscription "5e390ec8-67e1-45e2-bbaa-0fa2542faba6"

# Stop and deallocate the VM before changing the storage type
Stop-AzVM -ResourceGroupName keywatcher_RG -Name az6B65wappp1 -Force -Verbose -NoWait

# Import the CSV into a variable
$AZdisks = Import-Csv -Path 'C:\Premium SSD to Standard SSD\340604-313265-OIT Network Infrastructure.csv'
            
foreach ($AZdisk in $AZdisks)            
{   
    # Imports the data from the CSV in each row into a variable         
    $diskname = $AZdisk.Name
    $resourcegroup = $AZdisk.RG
    $storageType = 'StandardSSD_LRS'
    
    # Gather disk info
    $disk = Get-AzDisk -DiskName $diskname -ResourceGroupName $resourcegroup
           
    # Update the storage type
    $disk.Sku = [Microsoft.Azure.Management.Compute.Models.DiskSku]::new($storageType)
    $disk | Update-AzDisk
    Write-Output "The disk '$diskname' has been converted successfully." `n
}

Start-AzVM -ResourceGroupName keywatcher_RG -Name az6B65wappp1 -Verbose -NoWait


##### Connects PS session to subscription name 340604-313267-Network Operations
Set-AzContext -subscription "c4b34148-c5fb-4664-b736-0c1911f1ef3f"

# Stop and deallocate the VM before changing the storage type
Stop-AzVM -ResourceGroupName netperf_RG -Name az4E65lappp1 -Force -Verbose -NoWait
Stop-AzVM -ResourceGroupName UTArlingtonHubIdentityResourceGroup -Name azdcwapp01 -Force -Verbose -NoWait
Stop-AzVM -ResourceGroupName UTArlingtonHubIdentityResourceGroup -Name azdcwapp02 -Force -Verbose -NoWait
Stop-AzVM -ResourceGroupName dns_RG -Name azdnswapp01 -Force -Verbose -NoWait
Stop-AzVM -ResourceGroupName dns_RG -Name azdnswapp02 -Force -Verbose -NoWait
Stop-AzVM -ResourceGroupName UTArlingtonHubIdentityResourceGroup -Name azidmlapp01 -Force -Verbose -NoWait
Stop-AzVM -ResourceGroupName UTArlingtonHubIdentityResourceGroup -Name azdcwapp02 -Force -Verbose -NoWait
Stop-AzVM -ResourceGroupName UTArlingtonHubIdentityResourceGroup -Name azidmlapp03 -Force -Verbose -NoWait
Stop-AzVM -ResourceGroupName UTArlingtonHubIdentityResourceGroup -Name azidmwapp01 -Force -Verbose -NoWait
Stop-AzVM -ResourceGroupName UTArlingtonHubIdentityResourceGroup -Name azidmwapp02 -Force -Verbose -NoWait

# Import the CSV into a variable
$AZdisks = Import-Csv -Path 'C:\Premium SSD to Standard SSD\340604-313267-Network Operations.csv'
            
foreach ($AZdisk in $AZdisks)            
{   
    # Imports the data from the CSV in each row into a variable         
    $diskname = $AZdisk.Name
    $resourcegroup = $AZdisk.RG
    $storageType = 'StandardSSD_LRS'
    
    # Gather disk info
    $disk = Get-AzDisk -DiskName $diskname -ResourceGroupName $resourcegroup
           
    # Update the storage type
    $disk.Sku = [Microsoft.Azure.Management.Compute.Models.DiskSku]::new($storageType)
    $disk | Update-AzDisk
    Write-Output "The disk '$diskname' has been converted successfully." `n
}

Start-AzVm -ResourceGroupName netperf_RG -Name az4E65lappp1 -Verbose -NoWait
Start-AzVm -ResourceGroupName UTArlingtonHubIdentityResourceGroup -Name azdcwapp01 -Verbose -NoWait
Start-AzVm -ResourceGroupName UTArlingtonHubIdentityResourceGroup -Name azdcwapp02 -Verbose -NoWait
Start-AzVm -ResourceGroupName dns_RG -Name azdnswapp01 -Verbose -NoWait 
Start-AzVm -ResourceGroupName dns_RG -Name azdnswapp02 -Verbose -NoWait 
Start-AzVm -ResourceGroupName UTArlingtonHubIdentityResourceGroup -Name azidmlapp01 -Verbose -NoWait
Start-AzVm -ResourceGroupName UTArlingtonHubIdentityResourceGroup -Name azdcwapp02 -Verbose -NoWait 
Start-AzVm -ResourceGroupName UTArlingtonHubIdentityResourceGroup -Name azidmlapp03 -Verbose -NoWait
Start-AzVm -ResourceGroupName UTArlingtonHubIdentityResourceGroup -Name azidmwapp01 -Verbose -NoWait
Start-AzVm -ResourceGroupName UTArlingtonHubIdentityResourceGroup -Name azidmwapp02 -Verbose -NoWait


##### Connects PS session to subscription name 340604-313268-Security Operations
Set-AzContext -subscription "d50eb77e-883d-4239-aa8a-a534060962e6"

# Stop and deallocate the VM before changing the storage type
Stop-AzVM -ResourceGroupName ParseDmarc_RG -Name az5061lappp1 -Force -Verbose -NoWait

# Import the CSV into a variable
$AZdisks = Import-Csv -Path 'C:\Premium SSD to Standard SSD\340604-313268-Security Operations.csv'
            
foreach ($AZdisk in $AZdisks)            
{   
    # Imports the data from the CSV in each row into a variable         
    $diskname = $AZdisk.Name
    $resourcegroup = $AZdisk.RG
    $storageType = 'StandardSSD_LRS'
    
    # Gather disk info
    $disk = Get-AzDisk -DiskName $diskname -ResourceGroupName $resourcegroup
           
    # Update the storage type
    $disk.Sku = [Microsoft.Azure.Management.Compute.Models.DiskSku]::new($storageType)
    $disk | Update-AzDisk
    Write-Output "The disk '$diskname' has been converted successfully." `n
}

Start-AzVM -ResourceGroupName ParseDmarc_RG -Name az5061lappp1 -Verbose -NoWait


##### Connects PS session to subscription name 340604-313269-OIT Research Services
Set-AzContext -subscription "5f04c338-5464-4363-82e3-279551c44fcd"

# Stop and deallocate the VM before changing the storage type
Stop-AzVM -ResourceGroupName researchworkstation_RG -Name az7265lappp1 -Force -Verbose -NoWait
Stop-AzVM -ResourceGroupName researchworkstation_RG -Name az7265lappp2 -Force -Verbose -NoWait
Stop-AzVM -ResourceGroupName researchworkstation_RG -Name az7265lappp3 -Force -Verbose -NoWait
Stop-AzVM -ResourceGroupName researchworkstation_RG -Name az7265lappp4 -Force -Verbose -NoWait
Stop-AzVM -ResourceGroupName reverseproxy_RG -Name az7265lwebp2 -Force -Verbose -NoWait

# Import the CSV into a variable
$AZdisks = Import-Csv -Path 'C:\Premium SSD to Standard SSD\340604-313269-OIT Research Services.csv'
            
foreach ($AZdisk in $AZdisks)            
{   
    # Imports the data from the CSV in each row into a variable         
    $diskname = $AZdisk.Name
    $resourcegroup = $AZdisk.RG
    $storageType = 'StandardSSD_LRS'
    
    # Gather disk info
    $disk = Get-AzDisk -DiskName $diskname -ResourceGroupName $resourcegroup
           
    # Update the storage type
    $disk.Sku = [Microsoft.Azure.Management.Compute.Models.DiskSku]::new($storageType)
    $disk | Update-AzDisk
    Write-Output "The disk '$diskname' has been converted successfully." `n
}

Start-AzVm -ResourceGroupName researchworkstation_RG -Name az7265lappp1 -Verbose -NoWait
Start-AzVm -ResourceGroupName researchworkstation_RG -Name az7265lappp2 -Verbose -NoWait
Start-AzVm -ResourceGroupName researchworkstation_RG -Name az7265lappp3 -Verbose -NoWait
Start-AzVm -ResourceGroupName researchworkstation_RG -Name az7265lappp4 -Verbose -NoWait
Start-AzVm -ResourceGroupName reverseproxy_RG -Name az7265lwebp2 -Verbose -NoWait


##### Connects PS session to subscription name 340604-313273-OIT Enterprise Data Services
Set-AzContext -subscription "981b03a9-d4f3-45a3-b7f2-e06c85288639"

# Stop and deallocate the VM before changing the storage type
Stop-AzVM -ResourceGroupName ehsmssql_RG -Name az6568wdbp1 -Force -Verbose -NoWait
Stop-AzVM -ResourceGroupName mars_development_RG -Name az6D61lappd1 -Force -Verbose -NoWait
Stop-AzVM -ResourceGroupName mars_development_RG -Name az6D61lappd2 -Force -Verbose -NoWait
Stop-AzVM -ResourceGroupName mars_RG -Name az6D61lappp1 -Force -Verbose -NoWait
Stop-AzVM -ResourceGroupName mars_RG -Name az6D61lappp2 -Force -Verbose -NoWait
Stop-AzVM -ResourceGroupName mars_RG -Name az6D61lappp3 -Force -Verbose -NoWait
Stop-AzVM -ResourceGroupName mars_test_RG -Name az6D61lappt1 -Force -Verbose -NoWait
Stop-AzVM -ResourceGroupName mars_test_RG -Name az6D61lappt2 -Force -Verbose -NoWait
Stop-AzVM -ResourceGroupName mars_RG -Name az6D61ldbp1 -Force -Verbose -NoWait
Stop-AzVM -ResourceGroupName mars_test_RG -Name az6D61ldbt1 -Force -Verbose -NoWait

# Import the CSV into a variable
$AZdisks = Import-Csv -Path 'C:\Premium SSD to Standard SSD\340604-313273-OIT Enterprise Data Services.csv'
            
foreach ($AZdisk in $AZdisks)            
{   
    # Imports the data from the CSV in each row into a variable         
    $diskname = $AZdisk.Name
    $resourcegroup = $AZdisk.RG
    $storageType = 'StandardSSD_LRS'
    
    # Gather disk info
    $disk = Get-AzDisk -DiskName $diskname -ResourceGroupName $resourcegroup
           
    # Update the storage type
    $disk.Sku = [Microsoft.Azure.Management.Compute.Models.DiskSku]::new($storageType)
    $disk | Update-AzDisk
    Write-Output "The disk '$diskname' has been converted successfully." `n
}

Start-AzVm -ResourceGroupName ehsmssql_RG -Name az6568wdbp1 -Verbose -NoWait
Start-AzVm -ResourceGroupName mars_development_RG -Name az6D61lappd1 -Verbose -NoWait 
Start-AzVm -ResourceGroupName mars_development_RG -Name az6D61lappd2 -Verbose -NoWait 
Start-AzVm -ResourceGroupName mars_RG -Name az6D61lappp1 -Verbose -NoWait 
Start-AzVm -ResourceGroupName mars_RG -Name az6D61lappp2 -Verbose -NoWait 
Start-AzVm -ResourceGroupName mars_RG -Name az6D61lappp3 -Verbose -NoWait 
Start-AzVm -ResourceGroupName mars_test_RG -Name az6D61lappt1 -Verbose -NoWait 
Start-AzVm -ResourceGroupName mars_test_RG -Name az6D61lappt2 -Verbose -NoWait 
Start-AzVm -ResourceGroupName mars_RG -Name az6D61ldbp1 -Verbose -NoWait 
Start-AzVm -ResourceGroupName mars_test_RG -Name az6D61ldbt1 -Verbose -NoWait


##### Connects PS session to subscription name 340604-313275-OIT Application Development
Set-AzContext -subscription "c0e9e099-a39f-4860-94a7-32be365e2999"

# Stop and deallocate the VM before changing the storage type
Stop-AzVM -ResourceGroupName servicenow_development_RG -Name az7365wappd1 -Force -Verbose -NoWait
Stop-AzVM -ResourceGroupName servicenow_RG -Name az7365wappp1 -Force -Verbose -NoWait

# Import the CSV into a variable
$AZdisks = Import-Csv -Path 'C:\Premium SSD to Standard SSD\340604-313275-OIT Application Development.csv'
            
foreach ($AZdisk in $AZdisks)            
{   
    # Imports the data from the CSV in each row into a variable         
    $diskname = $AZdisk.Name
    $resourcegroup = $AZdisk.RG
    $storageType = 'StandardSSD_LRS'
    
    # Gather disk info
    $disk = Get-AzDisk -DiskName $diskname -ResourceGroupName $resourcegroup
           
    # Update the storage type
    $disk.Sku = [Microsoft.Azure.Management.Compute.Models.DiskSku]::new($storageType)
    $disk | Update-AzDisk
    Write-Output "The disk '$diskname' has been converted successfully." `n
}

Start-AzVM -ResourceGroupName servicenow_development_RG -Name az7365wappd1 -Verbose -NoWait 
Start-AzVM -ResourceGroupName servicenow_RG -Name az7365wappp1 -Verbose -NoWait 


##### Connects PS session to subscription name 340604-313430-Startup-PRV-Liwei Zhang
Set-AzContext -subscription "041de4d7-bbbe-43bd-9d12-e7c7b28744e0"

# Stop and deallocate the VM before changing the storage type
Stop-AzVM -ResourceGroupName tecplot_RG -Name az7465wappp1 -Force -Verbose -NoWait

# Import the CSV into a variable
$AZdisks = Import-Csv -Path 'C:\Premium SSD to Standard SSD\340604-313430-Startup-PRV-Liwei Zhang.csv'
            
foreach ($AZdisk in $AZdisks)            
{   
    # Imports the data from the CSV in each row into a variable         
    $diskname = $AZdisk.Name
    $resourcegroup = $AZdisk.RG
    $storageType = 'StandardSSD_LRS'
    
    # Gather disk info
    $disk = Get-AzDisk -DiskName $diskname -ResourceGroupName $resourcegroup
           
    # Update the storage type
    $disk.Sku = [Microsoft.Azure.Management.Compute.Models.DiskSku]::new($storageType)
    $disk | Update-AzDisk
    Write-Output "The disk '$diskname' has been converted successfully." `n
}

Start-AzVM -ResourceGroupName tecplot_RG -Name az7465wappp1 -Verbose -NoWait


##### Connects PS session to subscription name 340604-313933-System Operations
Set-AzContext -subscription "5eecc4cf-a5b9-4d0f-a457-dfced8c787fd"

# Stop and deallocate the VM before changing the storage type
Stop-AzVM -ResourceGroupName parkplace_RG -Name az7061wappp1 -Force -Verbose -NoWait
Stop-AzVM -ResourceGroupName wsus_RG -Name az7773wappp1 -Force -Verbose -NoWait

# Import the CSV into a variable
$AZdisks = Import-Csv -Path 'C:\Premium SSD to Standard SSD\340604-313933-System Operations.csv'
            
foreach ($AZdisk in $AZdisks)            
{   
    # Imports the data from the CSV in each row into a variable         
    $diskname = $AZdisk.Name
    $resourcegroup = $AZdisk.RG
    $storageType = 'StandardSSD_LRS'
    
    # Gather disk info
    $disk = Get-AzDisk -DiskName $diskname -ResourceGroupName $resourcegroup
           
    # Update the storage type
    $disk.Sku = [Microsoft.Azure.Management.Compute.Models.DiskSku]::new($storageType)
    $disk | Update-AzDisk
    Write-Output "The disk '$diskname' has been converted successfully." `n
}

Start-AzVM -ResourceGroupName parkplace_RG -Name az7061wappp1 -Verbose -NoWait 
Start-AzVM -ResourceGroupName wsus_RG -Name az7773wappp1 -Verbose -NoWait 


##### Connects PS session to subscription name 340604-470067-UTA Health Services
Set-AzContext -subscription "559bba62-1e98-4d32-acae-8fcccf76df9a"

# Stop and deallocate the VM before changing the storage type
Stop-AzVM -ResourceGroupName propharm_RG -Name az7072wappp1 -Force -Verbose -NoWait

# Import the CSV into a variable
$AZdisks = Import-Csv -Path 'C:\Premium SSD to Standard SSD\340604-470067-UTA Health Services.csv'
            
foreach ($AZdisk in $AZdisks)            
{   
    # Imports the data from the CSV in each row into a variable         
    $diskname = $AZdisk.Name
    $resourcegroup = $AZdisk.RG
    $storageType = 'StandardSSD_LRS'
    
    # Gather disk info
    $disk = Get-AzDisk -DiskName $diskname -ResourceGroupName $resourcegroup
           
    # Update the storage type
    $disk.Sku = [Microsoft.Azure.Management.Compute.Models.DiskSku]::new($storageType)
    $disk | Update-AzDisk
    Write-Output "The disk '$diskname' has been converted successfully." `n
}

Start-AzVM -ResourceGroupName propharm_RG -Name az7072wappp1 -Verbose -NoWait


##### Connects PS session to subscription name 340604-470175-Mav Express
Set-AzContext -subscription "329f6ddd-8003-4747-b6da-6970b4afbc23"

# Stop and deallocate the VM before changing the storage type
Stop-AzVM -ResourceGroupName csgold_RG -Name az6373wappp1 -Force -Verbose -NoWait
Stop-AzVM -ResourceGroupName csgold_RG -Name az6373wappp2 -Force -Verbose -NoWait
Stop-AzVM -ResourceGroupName csgold_RG -Name az6373wdbp1 -Force -Verbose -NoWait
Stop-AzVM -ResourceGroupName csgold_RG -Name az6373wwebp1 -Force -Verbose -NoWait
Stop-AzVM -ResourceGroupName mavexpress_RG -Name az6D61wappp1 -Force -Verbose -NoWait

# Import the CSV into a variable
$AZdisks = Import-Csv -Path 'C:\Premium SSD to Standard SSD\340604-470175-Mav Express.csv'
            
foreach ($AZdisk in $AZdisks)            
{   
    # Imports the data from the CSV in each row into a variable         
    $diskname = $AZdisk.Name
    $resourcegroup = $AZdisk.RG
    $storageType = 'StandardSSD_LRS'
    
    # Gather disk info
    $disk = Get-AzDisk -DiskName $diskname -ResourceGroupName $resourcegroup
           
    # Update the storage type
    $disk.Sku = [Microsoft.Azure.Management.Compute.Models.DiskSku]::new($storageType)
    $disk | Update-AzDisk
    Write-Output "The disk '$diskname' has been converted successfully." `n
}

Start-AzVm -ResourceGroupName csgold_RG -Name az6373wappp1 -Verbose -NoWait 
Start-AzVm -ResourceGroupName csgold_RG -Name az6373wappp2 -Verbose -NoWait 
Start-AzVm -ResourceGroupName csgold_RG -Name az6373wdbp1 -Verbose -NoWait 
Start-AzVm -ResourceGroupName csgold_RG -Name az6373wwebp1 -Verbose -NoWait
Start-AzVm -ResourceGroupName mavexpress_RG -Name az6D61wappp1 -Verbose -NoWait

# Stop logging
Stop-transcript