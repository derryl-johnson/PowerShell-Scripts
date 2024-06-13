Get-AzSubscription | where name -Like 34* | Foreach-Object {
    $sub = Set-AzContext -SubscriptionId $_.SubscriptionId
    $vnets = Get-AzVirtualNetwork

    foreach ($vnet in $vnets) {
        [PSCustomObject]@{
            Subscription = $sub.Subscription.Name
            Name = $vnet.Name
            Subnets = $vnet.Subnets.AddressPrefix -join ', ' # -join is used in case there are more than one subnet
        }
    }
} | Out-GridView