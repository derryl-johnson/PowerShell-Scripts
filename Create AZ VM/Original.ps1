# This will help make the correct selections for each mandatory value

# Get subscription info
# $SubscriptionId = (Get-AzSubscription | Out-GridView -PassThru -Title 'Select Subscription')

# Get cost center number from subscription name
# $costCeneter = $SubscriptionId.name.Substring(0,6)

# Get department code from subscription name
# $SubscriptionId.name.Substring(7,6)

# Get cost center name from subscription name
# $SubscriptionId.name.Substring(14)

# Get server size
# Get-AzVMSize -Location "southcentralus"

Param
(
    # Department Cost Center
    [Parameter(Mandatory=$true)] # 313262
    [String] $costCenter,
    # Department Code
    [Parameter(Mandatory=$true)] # 340600
    [String] $departmentCodeNumber,
    # Department Cost Center Name
    [Parameter(Mandatory=$true)] # OIT IO Administration
    [String] $costCenterName,
    # Application Name
    [Parameter(Mandatory=$true)] # Off_The_Shelf
    [String] $applicationName,
    # Server Operating System
    [Parameter(Mandatory=$true)] # ubuntu, oracle19, rhel8, windows
    [String] $serverOS,
    # Server Disk Size
    [Parameter(Mandatory=$true)] # 50
    [String] $diskSize,
    # Environment Type
    [Parameter(Mandatory=$true)] # production, test, development
    [String] $environmentType,
    # Server Type
    [Parameter(Mandatory=$true)] # application=app, web=web, database=db, report=rpt, agent=agt
    [String] $serverType,
    # Server Size
    # default = "Standard_D2s_v4" 2 vcpu, 8 GiB memory
    # medium = "Standard_D4s_v4" 4 vcpu, 16 GiB memory
    # large = "Standard_D8s_v4" 8 vcpu, 32 GiB memory
    # XL = "Standard_D16s_v4 16 vcpu, 64 GiB memory
    #
    # Memory Optimized for Oracle
    # default = "Standard_E2s_v4" 2 vcpu, 16 GiB memory
    # medium = "Standard_E4s_v4" 4 vcpu, 32 GiB memory
    # large = "Standard_E8s_v4" 8 vcpu, 64 GiB memory
    # XL = "Standard_E16s_v4" 16 vcpu, 128 GiB memory
    [Parameter(Mandatory=$true)]
    [String] $serverSize,
    # VNET IP Range
    [Parameter(Mandatory=$true)] # 10.208.8.64/26
    [String] $vnetRange,
    # Subnet Range for Default Subnet
    [Parameter(Mandatory=$true)] # 10.208.8.64/27
    [String] $subnetRangeDefault,
    # Subnet Range for Bastion Subnet
    [Parameter(Mandatory=$true)] # 10.208.8.96/27
    [String] $subnetRangeBastion,
    # ServiceNow passes request number
    [Parameter(Mandatory=$true)] # REQxxxxxxx
    [String] $requestNumber,
    # ServiceNow passes ture/false 
    [Parameter(Mandatory=$true)] # true
    [String] $selfSupport
)

# Ensures you do not inherit an AzContext in your runbook
Disable-AzContextAutosave -Scope Process

$connectionName = "AzureRunAsConnection"
try
{
    # Get the connection "AzureRunAsConnection "
    $servicePrincipalConnection=Get-AutomationConnection -Name $connectionName         

    Connect-AzAccount `
        -ServicePrincipal `
        -TenantId $servicePrincipalConnection.TenantId `
        -ApplicationId $servicePrincipalConnection.ApplicationId `
        -CertificateThumbprint $servicePrincipalConnection.CertificateThumbprint 
}
catch {
    if (!$servicePrincipalConnection)
    {
        $ErrorMessage = "Connection $connectionName not found."
        throw $ErrorMessage
    } else{
        Write-Error -Message $_.Exception
        throw $_.Exception
    }
}

function Create-ResourceGroup {
    #Deploy new Resource Group with tags
    New-AzResourceGroup -Name $resourceGroupName -Location $location #-Tag @{"Cost Center"="$costCenter"; "Department Code"="$departmentCode";"Environment"="$environmentType";"Request"="$requestNumber"}
    $tagsRG = @{"Cost Center"="$costCenter"; "Department Code"="$departmentCode";"Application"="$applicationName";"Environment"="$environmentType";"Request"="$requestNumber"}
    New-AzTag -ResourceId "/subscriptions/$subscriptionId/resourceGroups/$resourceGroupName" -Tag $tagsRG
}

function Create-VNET {
    # Create VNET with tags
    Write-Output "Creating VNET... $virtualNetworkName"
    Write-Output "Vnet range: $vnetRange"
    Write-Output "Subnet Default range: $subnetRangeDefault"
    Write-Output "Subnet Bastion range: $subnetRangeBastion"
    
    $default = New-AzVirtualNetworkSubnetConfig -Name "$subnetNameDefault" -AddressPrefix $subnetRangeDefault
    $bastion = New-AzVirtualNetworkSubnetConfig -Name "$subnetNameBastion" -AddressPrefix $subnetRangeBastion
    
    $parametersVNET = @{
    Name              = $virtualNetworkName
    ResourceGroupName = $resourceGroupName
    Location          = $location
    AddressPrefix     = $vnetRange
    DnsServer         = $dnsServers
    Subnet            = $default, $bastion
    Verbose           = $true
    }

    New-AzVirtualNetwork @parametersVNET

    # Gets virtual network details
    $newVirtualNetwork = Get-AzVirtualNetwork -Name $virtualNetworkName -ResourceGroupName $resourceGroupName
    
    $tagsVNET = @{"Request"="$requestNumber"}

    Update-AzTag -ResourceId "/subscriptions/$subscriptionId/resourceGroups/$resourceGroupName/providers/Microsoft.Network/virtualNetworks/$virtualNetworkName" -Tag $tagsVNET -Operation Merge

    # Have to set subscription so resource group can be found
    $subscriptionValueVirtualWAN = Get-AzSubscription -SubscriptionId $virtualWANSubscriptionId
    Set-AzContext -SubscriptionObject $subscriptionValueVirtualWAN
    # Set Virtual Hub connection name
    $virtualHubConnectionName = "$virtualHubName-to-$virtualNetworkName"
    # Create new Virtual Hub connection. This connects the newly created VNET to the secured hub (vWAN) protected with Azure Firewall
    New-AzVirtualHubVnetConnection -ResourceGroupName $virtualHubRGName -VirtualHubName $virtualHubName -Name $virtualHubConnectionName -RemoteVirtualNetwork $newVirtualNetwork

    # Configure Virtual Network connections in hub to propagate to None
    $Spoke1Connection = Get-AzVirtualHubVnetConnection -ResourceGroupName $virtualHubRGName -VirtualHubName $virtualHubName -Name $examplevirtualHubConnectionName
    $VnetRoutingConfig = $Spoke1Connection.RoutingConfiguration    # We take $Spoke1Connection as baseline for the future vnet config, all vnets will have an identical config
    $NoneRT = Get-AzVhubRouteTable -ResourceGroupName $virtualHubRGName -HubName $virtualHubName -Name "noneRouteTable"
    $NewPropRT = @{}
    $NewPropRT.Add('Id', $NoneRT.id)
    $PropRTList = @()
    $PropRTList += $NewPropRT
    #$VnetRoutingConfig.PropagatedRouteTables.Ids = $PropRTList
    $VnetRoutingConfig.PropagatedRouteTables.Labels = @()
    #$Spoke1Connection = Update-AzVirtualHubVnetConnection -ResourceGroupName $RG -ParentResourceName  $HubName -Name "spoke1" -RoutingConfiguration $VnetRoutingConfig
    $Spoke2Connection = Update-AzVirtualHubVnetConnection -ResourceGroupName $virtualHubRGName -ParentResourceName  $virtualHubName -Name "$virtualHubConnectionName" -RoutingConfiguration $VnetRoutingConfig
}

function Create-NSG {
    # Create NSG and remote access rule
    $rule1 = New-AzNetworkSecurityRuleConfig -Name $ruleName -Description "$ruleDescription" `
    -Access Allow -Protocol Tcp -Direction Inbound -Priority 100 -SourceAddressPrefix `
    $pawIPSpace -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange $ruleDestinationPortRange
    
    $nsg = New-AzNetworkSecurityGroup -ResourceGroupName "$resourceGroupName"  -Location  "$location" -Name $applicationNameNSG -SecurityRules $rule1

    Set-AzVirtualNetworkSubnetConfig -Name $subnetNameDefault -VirtualNetwork $newVirtualNetwork -AddressPrefix "$subnetRangeDefault" -NetworkSecurityGroup $nsg
    $newVirtualNetwork | Set-AzVirtualNetwork
}

function Create-VM {
    #Deploy new VM with tags set subscription
    $subscription = Get-AzSubscription -SubscriptionName $baseServerSub
    Set-AzContext -SubscriptionObject $subscription
    New-AzResourceGroupDeployment @parameters
    $tagsVM = @{"Request"="$requestNumber"}

    Update-AzTag -ResourceId "/subscriptions/$subscriptionId/resourceGroups/$resourceGroupName/providers/Microsoft.Compute/virtualMachines/$vmName" -Tag $tagsVM -Operation Merge
    $vmResourceId = "/subscriptions/$subscriptionId/resourceGroups/$resourceGroupName/providers/Microsoft.Compute/virtualMachines/$vmName"

    Write-Host "ServerNow Request: $requestNumber"
    Write-Host "Subscription: $baseServerSub"
    Write-Host "ResourceGroupName: $resourceGroupName"
    Write-Host "VM server name requested: $vmName"
    Write-Host "Server OS selected to deployed: $serverOS"
    Write-Host "Server OS type deployed: $serverOSType"
    Write-Host "Virtual network resource group name: $virtualNetworkResourceGroup"
    Write-Host "VM Resource ID: $vmResourceId"
}

function Create-AzureDnsRecord {
    Write-Host "IP Address: $AzDnsIPv4Address"
    $subscriptionDNS = Get-AzSubscription -SubscriptionId $DNSZoneSubscriptionId
    Set-AzContext -SubscriptionObject $subscriptionDNS

    New-AzPrivateDnsRecordSet -Name $vmName -RecordType A -ZoneName $AzPrivateDnsZone -ResourceGroupName $AzPrivateDnsResourceGroup -Ttl 3600 -PrivateDnsRecords (New-AzPrivateDnsRecordConfig -IPv4Address "$AzDnsIPv4Address")    
}

function Create-AzureDnsPtrRecord {
    $AzDnsPtrIp = $AzDnsIPv4Address
    $AzDnsValues = Get-AzPrivateDnsRecordSet -ResourceGroupName $AzPrivateDnsResourceGroup -ZoneName $AzPrivateDnsZone -Name $vmName -RecordType A 
    $AzDnsName = "$($AzDnsValues.Name).$($AzDnsValues.ZoneName)"

    $AzDnsPtrArr = $AzDnsPtrIp -split '\.'

    [array]::Reverse($AzDnsPtrArr) | Out-Null

    $NameIndexRange = 0,1
    $ZoneIndexRange = 2,3

    $AzDnsPtrName = $AzDnsPtrArr[$NameIndexRange] -join '.'
    $AzDnsPtrZonePrefix = $AzDnsPtrArr[$ZoneIndexRange] -join '.'
    $AzDnsPtrZone = "$AzDnsPtrZonePrefix.in-addr.arpa"

    Write-Host "PTR Name: $AzDnsPtrZone"

    $subscriptionDNS = Get-AzSubscription -SubscriptionId $DNSZoneSubscriptionId
    Set-AzContext -SubscriptionObject $subscriptionDNS

    New-AzPrivateDnsRecordSet -Name $AzDnsPtrName -RecordType PTR -ZoneName $AzDnsPtrZone -ResourceGroupName $AzPrivateDnsResourceGroup -Ttl 3600 -PrivateDnsRecords (New-AzPrivateDnsRecordConfig -Ptrdname $AzDnsName)    
}

##### Constants
$departmentCodeSystemOps = "340604"
$storageAccountConnectionString ="DefaultEndpointsProtocol=https;AccountName=utaautomationtest;AccountKey=XwubmLw+2jjLFUB/rD0Dc+Rrr7/+iNR7jPx2erUnKTpc0RmW2OKbsXjJtWTvek08Yopf4BYKRQ/SXaKh2o93SA==;"
$shareName = "resource-templates"
$deploymentParametersPath = "deploy.parameters.json"
$deploymentPathWindows = "windowsdeploy.json"
$deploymentPathUbuntu = "ubuntudeploy.json"
$deploymentPathOracle19 = "oracle19deploy.json"
$deploymentPathRhel8 = "rhel8deploy.json"
$datacenter = "az"
$destination = "C:\Temp"
# Azure datacenter location
$location = "southcentralus"
# Set to virtual hub's name
$virtualHubName = "vWAN_SouthCentral_HUB"
# Set to virtual hub's RG
$virtualHubRGName = "vWAN_SouthCentral_RG"
# This value is used to set routing to no for other new vWAN setups
$examplevirtualHubConnectionName = "dns_VNET_vWAN_On_Prem"
# Set to virtual hub's subscription
$virtualWANSubscriptionId = "c4b34148-c5fb-4664-b736-0c1911f1ef3f"
$DNSZoneSubscriptionId = "c4b34148-c5fb-4664-b736-0c1911f1ef3f"
$AzPrivateDnsResourceGroup = "dns_RG"
$AzPrivateDnsZone = "az.uta.edu"
$subnetNameDefault = "default"
$subnetNameBastion = "AzureBastionSubnet"

## Server naming convention
# Using cost center
$costCenterShortName = "$costCenter"

# Creates a HEX from application name, removes spaces and selects first four characters
#$applicationName = "Image Now";
#$b = $applicationName.ToCharArray();
#$hexName = ""
#Foreach ($element in $b) {$hexName = $hexName + " " + [System.String]::Format("{0:X2}", [System.Convert]::ToUInt32($element))}
#$hexName = $hexName.replace(' ','').Substring(0,4)
#Write-Output $hexName

# Set serverOSType
If ($serverOSType)
{
    Clear-Variable serverOSType
}
if ($serverOS -eq "ubuntu" -or $serverOS -eq "oracle19" -or $serverOS -eq "rhel8")
{
    $serverOSType = "linux"
}
elseif ($serverOS -eq "windows") 
{
    $serverOSType = "windows"
}
# Get first letter from $serverOS
$serverOSShort = $serverOSType.Substring(0,1)
# Get first letter from environment type
$environmentTypeCode = $environmentType.Substring(0,1)
# Creates a HEX from application name, removes spaces and selects first four characters
$b = $applicationName.ToCharArray();
$hexName = ""
Foreach ($element in $b) {
    $hexName = $hexName + " " + [System.String]::Format("{0:X2}", [System.Convert]::ToUInt32($element))
}
$hexName = $hexName.replace(' ','').Substring(0,4)
# Build Server Name
$name = "${datacenter}${hexName}${serverOSShort}${serverType}${environmentTypeCode}"
[int]$incrementvmName = 1
$vmName = $name+[string]$incrementvmName

# Server resource size for deployment
$vmSize = "$serverSize"
# Name the NSG
$applicationNameNSG = "${applicationName}-nsg"

# Check if server will be self supported
$condition = $selfSupport
if($condition -eq "true")
{
    # This value can be different based on how question is answered:
    # Will server administrative support need to be provided by OIT
    # If yes $departmentCode would be defaulted to "340604"
    # testing $departmentCode = "340600"
    $departmentCode = "$departmentCodeNumber"
}
else 
{
    # Department Code for System Operations 
    $departmentCode = "$departmentCodeSystemOps"
}

# Build server subcription based on naming convention
$baseServerSub = "$departmentCode-$costCenter-$costCenterName"

# Creates a context to storage account with the connection string
$ContextDeployParams = New-AzStorageContext -ConnectionString "$storageAccountConnectionString"

# Read files from stroage account and place in temp location
Get-AzStorageFileContent `
    -ShareName "$shareName" `
    -Context $ContextDeployParams `
    -path "$deploymentParametersPath" `
    -Destination "$destination" -Force

# Creates file path for server deployment file 
$deployTemplateParameterFile = Join-Path -Path "$destination" -ChildPath "$deploymentParametersPath"

# Department Name provied by MyMav oracle table view, key department code, column DESCR
#$department = "OIT Infrastructure Operations"
#$department = "Provost Office"
$managementGroupID = $departmentCode

### Production: $resourceGroupName = "${applicationName}_RG"
### Non_Prod: $resourceGroupName = "${applicationName}_${environmentType}_RG"
if ($environmentType -eq "production")
{
    $resourceGroupName = "${applicationName}_RG"    
}
else 
{
    $resourceGroupName = "${applicationName}_${environmentType}_RG"    
}

### Production: $virtualNetworkName = "${applicationName}_RG"
### Non_Prod: $virtualNetworkName = "${applicationName}_${environmentType}_RG"
if ($environmentType -eq "production")
{
    $virtualNetworkName = "${applicationName}_VNET"    
}
else 
{
    $virtualNetworkName = "${applicationName}_${environmentType}_VNET"    
}

# VNET Resource Group set to the created Resource Group
$virtualNetworkResourceGroup = "$resourceGroupName"

# Get managment group information
$managemntGroup = Get-AzManagementGroup -GroupID $departmentCode
# Get deployment location subscription information
$subscriptionValues = Get-AzSubscription -SubscriptionName $baseServerSub
$subscriptionId = $subscriptionValues.Id

Write-Output "-------------------------------"
Write-Output "Getting current subscription..."

If ($subscription)
{
    Clear-Variable subscription
}

$subscription = Get-AzSubscription -SubscriptionName $baseServerSub

# If subscription is already created insure it is under the correct managment group
If ($subscription.Name.Length -gt 1)
{
    Write-Output "Subscription found: $($subscription.name)"
    Set-AzContext -SubscriptionObject $subscription

    # Make sure managment group exists
    Write-Output "Verify that required Managment group exists"
    if ($managemntGroup.Name.Length -gt 1)
    {
        Write-Output "Managemnt Group found: $($managemntGroup.DisplayName)"
        # Make sure Subscription is under the correct management group
        Write-Output "Make sure Subscription is under the correct management group..." 
        Write-Output "Move: $baseServerSub to the following Managment Group: $managementGroupID"
        New-AzManagementGroupSubscription -GroupId $managementGroupID -SubscriptionId $($subscription.id)
        Write-Output "Make sure Subscription is under the correct management group...Completed"
    }
    else {
        Write-Output "Management Group not found. Please create a valid management group or insure department code is correct"
    }
}
# There is no subscription, create subscription and place under the correct managment group
Else
{    
    Write-Output "Error: Unable to find subscription"
    Write-Output "Create new subscription: $baseServerSub"
    
    # Creates subscription with tag
    #$tagsSUB = @{"Cost Center"="$costCenter"; "Department Code"="$departmentCode"; "Request"="$requestNumber"}
    #$subscription = New-AzSubscription -Name $baseServerSub -EnrollmentAccountObjectId ((Get-AzEnrollmentAccount)[0].ObjectId) -OfferType "MS-AZR-0017P"
    #Start-Sleep -s 30

    #$subscriptionValues = Get-AzSubscription -SubscriptionName $baseServerSub
    #$subscriptionId = $subscriptionValues.Id
    #$subscription = Get-AzSubscription -SubscriptionName $baseServerSub

    #New-AzTag -ResourceId "/subscriptions/$subscriptionId" -Tag $tagsSUB
    #Write-Output "NEW Subscription created: $baseServerSub" 

    # Make sure Subscription is under the correct management group
    #Write-Output "Make sure Subscription is under the correct management group..." 
    #Write-Output "Move: $baseServerSub to the following Managment Group: $managementGroupID"
    #New-AzManagementGroupSubscription -GroupId $managementGroupID -SubscriptionId $($subscription.id)
    #Write-Output "Make sure Subscription is under the correct management group...Completed"
    exit
}
Write-Output "-------------------------------"

# Check that VM Name is not already used
# Set subscription context back for VM deployment
# Increment number to create a unique server name
Set-AzContext -SubscriptionObject $subscription

$check = Get-AzVM -Name "$vmName" -ResourceGroupName "$resourceGroupName" -ErrorVariable notPresent -ErrorAction SilentlyContinue
if ($check.Name.Length -gt 1)
{
    do 
    {
        Write-Output "VM Name: $vmName matched and existing VM"
        Write-Output "The VM Name will be incremented"
        $incrementvmName ++
        $vmName = $name + [string]$incrementvmName
        Get-AzVM -Name "$vmName" -ResourceGroupName "$resourceGroupName" -ErrorVariable notPresent -ErrorAction SilentlyContinue
    }
    until ($notPresent)    
}

if ($serverOS -eq "windows")
{
    $deployOS = "windows"

    # Create a context to storage account with the connection string
    $ContextDeployFile = New-AzStorageContext -ConnectionString "DefaultEndpointsProtocol=https;AccountName=utaautomationtest;AccountKey=XwubmLw+2jjLFUB/rD0Dc+Rrr7/+iNR7jPx2erUnKTpc0RmW2OKbsXjJtWTvek08Yopf4BYKRQ/SXaKh2o93SA==;"

    # Read files from stroage account and place in temp location
    Get-AzStorageFileContent `
        -ShareName "$shareName" `
        -Context $ContextDeployFile `
        -path "$deploymentPathWindows" `
        -Destination "$destination" -Force

    # Creates file path for server deployment file    
    $deployTemplateFile = Join-Path -Path 'C:\Temp' -ChildPath 'windowsdeploy.json'

    $ruleName = "rdp-paw-rule"
    $ruleDescription = "Allow RDP from PAW"
    $pawIPSpace = "10.208.4.32/28"
    $ruleDestinationPortRange = "3389"
}
if ($serverOS -eq "ubuntu")
{
    $deployOS = "ubuntu"

    # Create a context to storage account with the connection string
    $ContextDeployFile = New-AzStorageContext -ConnectionString "DefaultEndpointsProtocol=https;AccountName=utaautomationtest;AccountKey=XwubmLw+2jjLFUB/rD0Dc+Rrr7/+iNR7jPx2erUnKTpc0RmW2OKbsXjJtWTvek08Yopf4BYKRQ/SXaKh2o93SA==;"

    # Read files from stroage account and place in temp location
    Get-AzStorageFileContent `
        -ShareName "$shareName" `
        -Context $ContextDeployFile `
        -path "$deploymentPathUbuntu" `
        -Destination "$destination" -Force

    # Creates file path for server deployment file    
    $deployTemplateFile = Join-Path -Path 'C:\Temp' -ChildPath 'ubuntudeploy.json'

    $ruleName = "ssh-paw-rule"
    $ruleDescription = "Allow SSH from PAW"
    $pawIPSpace = "10.208.4.32/28"
    $ruleDestinationPortRange = "22"
}
if ($serverOS -eq "rhel8")
{
    $deployOS = "rhel8"

    # Create a context to storage account with the connection string
    $ContextDeployFile = New-AzStorageContext -ConnectionString "DefaultEndpointsProtocol=https;AccountName=utaautomationtest;AccountKey=XwubmLw+2jjLFUB/rD0Dc+Rrr7/+iNR7jPx2erUnKTpc0RmW2OKbsXjJtWTvek08Yopf4BYKRQ/SXaKh2o93SA==;"

    # Read files from stroage account and place in temp location
    Get-AzStorageFileContent `
        -ShareName "$shareName" `
        -Context $ContextDeployFile `
        -path "$deploymentPathRhel8" `
        -Destination "$destination" -Force

    # Creates file path for server deployment file    
    $deployTemplateFile = Join-Path -Path 'C:\Temp' -ChildPath 'rhel8deploy.json'    

    $ruleName = "ssh-paw-rule"
    $ruleDescription = "Allow SSH from PAW"
    $pawIPSpace = "10.208.4.32/28"
    $ruleDestinationPortRange = "22"
}
if ($serverOS -eq "oracle19")
{
    $deployOS = "oracle19"

    # Create a context to storage account with the connection string
    $ContextDeployFile = New-AzStorageContext -ConnectionString "DefaultEndpointsProtocol=https;AccountName=utaautomationtest;AccountKey=XwubmLw+2jjLFUB/rD0Dc+Rrr7/+iNR7jPx2erUnKTpc0RmW2OKbsXjJtWTvek08Yopf4BYKRQ/SXaKh2o93SA==;"

    # Read files from stroage account and place in temp location
    Get-AzStorageFileContent `
        -ShareName "$shareName" `
        -Context $ContextDeployFile `
        -path "$deploymentPathOracle19" `
        -Destination "$destination" -Force

    # Creates file path for server deployment file    
    $deployTemplateFile = Join-Path -Path 'C:\Temp' -ChildPath 'oracle19deploy.json'
    
    $ruleName = "ssh-paw-rule"
    $ruleDescription = "Allow SSH from PAW"
    $pawIPSpace = "10.208.4.32/28"
    $ruleDestinationPortRange = "22"
}

if ($deployOS)
{
    $parameters = @{
    ResourceGroupName = "$resourceGroupName"
    
    # JSON files in this test script are uploaded to your storage account used for running this code via Azure Cloud Shell
    TemplateFile = "$deployTemplateFile"
    TemplateParameterFile = "$deployTemplateParameterFile"
    vmName = "$vmName"
    diskSize = "$diskSize"
    vmSize = "$vmSize"
    virtualNetworkName = "$virtualNetworkName"
    virtualNetworkResourceGroup = "$virtualNetworkResourceGroup"
    #networkSecurityGroupName = "$applicationNameNSG"
    subnetName = $subnetNameDefault
    Verbose = $true
    }

    #Find resource group
    $resourceGroup = Get-AzResourceGroup -Name $resourceGroupName -ErrorAction SilentlyContinue
    #Find virtual network
    $virtualNetwork = Get-AzVirtualNetwork -Name $virtualNetworkName

    # If the target resource group is found; Create Server/Application object in that resource group
    If ($resourceGroup.ResourceGroupName.Length -gt 1)
    {
        Write-Output "Resource group for vm deployment was found....true: $($resourceGroupName)"

        # Check VNET has been created
        If (!$virtualNetwork.ProvisioningState)
        {
            Write-Output "VNET is not deployed....true: $($virtualNetworkName)"
            
            # Create VNET with tags
            Create-VNET
        }

        #Deploy new VM with tags
        Create-VM

        # Get IP address for newly created VM
        $AzDnsIPv4Address = (Get-AzNetworkInterface -Name $vmName -ResourceGroupName $resourceGroupName).IpConfigurations.PrivateIpAddress

        # Set DNS entries
        Create-AzureDnsRecord
        Create-AzureDnsPtrRecord
    }
    else 
    {
        Write-Output "Resource group for vm deployment was found....false: $($resourceGroupName)"
        Write-Host "Creating resource group for vm deployment: $($resourceGroupName)"
    
        #Deploy new Resource Group with tags
        Create-ResourceGroup
        
        # Create VNET with tags
        Create-VNET

        #Deploy new VM with tags
        Create-VM

        # Get IP address for newly created VM
        $AzDnsIPv4Address = (Get-AzNetworkInterface -Name $vmName -ResourceGroupName $resourceGroupName).IpConfigurations.PrivateIpAddress

        # Set DNS entries
        Create-AzureDnsRecord
        Create-AzureDnsPtrRecord
    }
}

Write-Host "Errors: --------"
#$Error