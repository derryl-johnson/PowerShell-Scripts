function Show-Menu
{
    param (
        [string]$Title = 'Server OS'
    )
    Clear-Host
    Write-Host "Server OS"
    
    Write-Host "1: Press '1' for New."
    Write-Host "2: Press '2' for Existing."
    Write-Host "3: Press '3' to quit."
}

 Show-Menu –Title 'My Menu'
 $selection = Read-Host "Please make a selection"
 switch ($selection)
 {
     '1' {
           $serveros = Read-Host "Enter new Server OS"
           Write-Host $serveros
     } '2' {
         $SubscriptionId = (Get-AzSubscription | Out-GridView -PassThru -Title 'Select Subscription')

         Write-Host $departmentcode-$costcenter-$ccname
     } '3' {
         return
     }
 }