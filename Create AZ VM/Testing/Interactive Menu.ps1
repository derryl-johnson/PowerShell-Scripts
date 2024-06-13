function Show-Menu
{
    param (
        [string]$Title = 'My Menu'
    )
    Clear-Host
    Write-Host "Cost Center Name"
    
    Write-Host "1: Press '1' for New."
    Write-Host "2: Press '2' for Existing."
    Write-Host "3: Press '3' to quit."
}

 Show-Menu –Title 'My Menu'
 $selection = Read-Host "Please make a selection"
 switch ($selection)
 {
     '1' {
           $new = Read-Host "Enter new cost center name:"
           Write-Host $new
     } '2' {
         $SubscriptionId = (Get-AzSubscription | Out-GridView -PassThru -Title 'Select Subscription')
         Write-Host $SubscriptionId.name.Substring(14)
     } '3' {
         return
     }
 }