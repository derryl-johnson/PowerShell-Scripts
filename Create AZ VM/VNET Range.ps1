function Show-Menu
{
    param (
        [string]$Title = 'VNET Range'
    )
    Clear-Host
    Write-Host "VNET Range"
    
    Write-Host "1: Press '1' for New."
    Write-Host "2: Press '2' for Existing."
    Write-Host "3: Press '3' to quit."
}

 Show-Menu –Title 'VNET Range'
 $selection = Read-Host "Please make a selection"
 switch ($selection)
 {
     '1' {
           $vnetrange = Read-Host "Enter VNET range"
           Write-Host $vnetrange
     } '2' {
         $vnetrange = (Get-AzSubscription | where name -Like 34* | Foreach-Object {
    $sub = Set-AzContext -SubscriptionId $_.SubscriptionId
    $vnets = Get-AzVirtualNetwork

    foreach ($vnet in $vnets) {
        [PSCustomObject]@{
            Subscription = $sub.Subscription.Name
            Name = $vnet.Name
            Subnets = $vnet.Subnets.AddressPrefix -join ', ' # -join is used in case there are more than one subnet
        }
    }
} | Out-GridView -PassThru -Title 'Select VNET')
    Write-Output $vnetrange.Subnets
         
     } '3' {
         return
     }
 }


