function Show-Menu
{
    param (
        [string]$Title = 'My Menu'
    )
    Clear-Host
    Write-Host "Subscription Information"
    
    Write-Host "1: Press '1' for New."
    Write-Host "2: Press '2' for Existing."
    Write-Host "3: Press '3' to quit."
}

 Show-Menu –Title 'My Menu'
 $selection = Read-Host "Please make a selection"
 switch ($selection)
 {
     '1' {
           $costcenter = Read-Host "Enter new cost center number"
           $departmentcode = Read-Host "Enter new department code number"
           $ccname = Read-Host "Enter new cost center name"
           Write-Host $departmentcode-$costcenter-$ccname
     } '2' {
         $SubscriptionId = (Get-AzSubscription | Out-GridView -PassThru -Title 'Select Subscription')
         $costcenter = $SubscriptionId.name.Substring(0,6)
         $departmentcode = $SubscriptionId.name.Substring(7,6)
         $ccname = $SubscriptionId.name.Substring(14)
         Write-Host $departmentcode-$costcenter-$ccname
     } '3' {
         return
     }
 }