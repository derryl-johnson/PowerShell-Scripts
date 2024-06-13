## Define Variables($Subscription) to collect subscription details and $Report to store all VM status along with OS Type, OS Version, VM Name, RG Name.

$Subscriptions = Get-AzureRmSubscription | Where-Object { $_.Name -in ("Prod", "Dev") }
$Report = ForEach ($Subscription in $Subscriptions) {
     $SubscriptionName = $Subscription.Name
     Set-AzureRmContext -SubscriptionName "$SubscriptionName" | Out-Null
     $RGs = Get-AzureRMResourceGroup
     foreach ($RG in $RGs) {
         $VMs = Get-AzureRmVM -ResourceGroupName $RG.ResourceGroupName
         foreach ($VM in $VMs) {
             # VM Status (running/deallocated/stopped)
             $VMDetail = Get-AzureRmVM -ResourceGroupName $RG.ResourceGroupName -Name $VM.Name -Status
             $VMStatusDetail = $VMDetail.Statuses.DisplayStatus -match "^VM .*$"
             New-Object psobject -Property @{
                 "SubscriptionName" = $SubscriptionName
                 "VMName"           = $VM.Name
                 "VMStatus"         = "$VMStatusDetail"
                 "OSType"           = $VM.StorageProfile.OSDisk.OSType
                 "OSVersion"        = $Vm.StorageProfile.ImageReference.Sku
                 "ResourceGroup"    = $RG.ResourceGroupName
                 "Location"         = $VM.Location
               }
          }
     }
 }
## End Subscription
## Pull the $Report variable to get all details and save in csv format.
$Report | Export-Csv "c:\users\$env:username\documents\Azure_VMs_Status.csv" -Force -NoTypeInformation