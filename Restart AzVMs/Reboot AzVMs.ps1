function Mav_Express #This subscription contains the VMs for the CSGold servers
{
    Restart-AzVM -Name az6373wdbp1 -ResourceGroupName csgold_RG -NoWait -Verbose
    
    Write-Output "The script will pause for 120 seconds while the csgold db server is rebooting before continuing."
    Start-Sleep -s 120

    Restart-AzVM -Name az6373wappp1 -ResourceGroupName csgold_RG -NoWait -Verbose
    Restart-AzVM -Name az6373wappp2 -ResourceGroupName csgold_RG -NoWait -Verbose

    Write-Output "The script will pause for 120 seconds while the csgold app servers are rebooting before continuing."
    Start-Sleep -s 120

    Restart-AzVM -Name az6373wwebp1 -ResourceGroupName csgold_RG -NoWait -Verbose
    Restart-AzVM -Name az6D61wappp1 -ResourceGroupName mavexpress_RG -NoWait -Verbose
    Restart-AzVM -Name smartonewapp03 -ResourceGroupName smartone_RG -NoWait -Verbose
}

function OIT_WVD #This is the subscription for the current PAWs
{
    Write-Output "The VMs in this subscription have been skipped."
}

function OIT_IO_Administration #This is the subscription for the old PAWs
{
    Write-Output "The VMs in this subscription have been skipped."
}

function Network_Operations #This is the subscription for the DNS and DCs
{
    Restart-AzVM -Name azdnswapp02 -ResourceGroupName dns_RG -NoWait -Verbose
    Restart-AzVM -Name azidmwapp01 -ResourceGroupName UTArlingtonHubIdentityResourceGroup -NoWait -Verbose
}

function Identity_Automation #This subscription contains azdcwapp03 & azdcwapp04
{
    Restart-AzVM -Name adaudit -ResourceGroupName adaudit_RG -NoWait -Verbose
    Restart-AzVM -Name az6964wappp1 -ResourceGroupName identitymanagement_RG -NoWait -Verbose
    Restart-AzVM -Name az6964wappp2 -ResourceGroupName identitymanagement_RG -NoWait -Verbose
    Restart-AzVM -Name az6B6Dwappp1 -ResourceGroupName kms_RG -NoWait -Verbose
    Restart-AzVM -Name az6B6Dwappp2 -ResourceGroupName kms_RG -NoWait -Verbose
    Restart-AzVM -Name azhwwapp02 -ResourceGroupName UTArlingtonAutomation-OrchestrationRG -NoWait -Verbose
    Restart-AzVM -Name azhwwapp03 -ResourceGroupName UTArlingtonAutomation-OrchestrationRG -NoWait -Verbose
    Restart-AzVM -Name azipamwapp01 -ResourceGroupName active-directory_RG -NoWait -Verbose
    Restart-AzVM -Name flowwapd01 -ResourceGroupName microsoftflow_RG -NoWait -Verbose
    Restart-AzVM -Name kms -ResourceGroupName kms_RG -NoWait -Verbose
    Restart-AzVM -Name kms2012 -ResourceGroupName kms_RG -NoWait -Verbose
    Restart-AzVM -Name rebus -ResourceGroupName passwordmanager_RG -NoWait -Verbose
}

<############################################################################################
The  functions below have been created as a workaround for the following scenario. If a 
subscription contains only one VM that fits within the Windows prod resource group parameters, 
then it results in  an error during the For loop. Until the error is resolved, the workaround 
is to use these functions to restart the VM individually instead of using the For loop.
#>

function Enterprise_Data_Services
{
    Restart-AzVM -Name az6461wappp1 -ResourceGroupName datafactory_RG -NoWait -Verbose
}

function Classroom_Support_Services
{
    Restart-AzVM -Name roomviewwapp01 -ResourceGroupName crestonroomview_RG -NoWait -Verbose
}

function Property_Management_Operating
{
    Restart-AzVM -Name assetswapp01 -ResourceGroupName inventorymanagement_rg -NoWait -Verbose
}

function Student_Orientation_Programs
{
    Restart-AzVM -Name vzenappprod -ResourceGroupName visualzen_rg -NoWait -Verbose
}

function Instructional_and_Advising_CE
{
    Restart-AzVM -Name simaprowapp03 -ResourceGroupName simapro_rg -NoWait -Verbose
}

function SSW_Professional_Development  
{
    Restart-AzVM -Name acewareprod -ResourceGroupName aceware_rg -NoWait -Verbose
}

function University_Analytics_M+O #M&O was replaced with M+O in case PS doesn't like the user of an ampersand as a function name
{
    Restart-AzVM -Name bbanalydb -ResourceGroupName blackboard_rg -NoWait -Verbose
}

function OIT_Application_Development
{
    Restart-AzVM -Name az7365wappp1 -ResourceGroupName servicenow_rg -NoWait -Verbose
}

function Startup-PRV-Liwei_Zhang
{
    Restart-AzVM -Name az7465wappp1 -ResourceGroupName tecplot_rg -NoWait -Verbose
}

function Campus_Recreation
{
    Restart-AzVM -Name fwiwapp01 -ResourceGroupName fourwinds_rg -NoWait -Verbose
}

function Intercollegiate_Athletics_ADMI
{
    Restart-AzVM -Name tcpluswapp01 -ResourceGroupName timeclockplus_rg -NoWait -Verbose
}

function College_Park_Center
{
    Restart-AzVM -Name cpc-castnet -ResourceGroupName digitalsignage_rg -NoWait -Verbose
}

function Civil_Engineering
{
    Restart-AzVM -Name civilwwbp01 -ResourceGroupName civilengineeringwebserver_rg -NoWait -Verbose
}

#Start logging
Start-transcript 'C:\reboot_prod_vms.txt'

#Gather the list of subscriptions that start with "340604" and "340502"
$subs = Get-AzSubscription
$sublists = $subs | Where-Object {($_.Name -like "340604*") -or ($_.Name -like "340502*")}

#Starts looping through each subscription 
foreach ($sublist in $sublists) 
{
    $subID = $sublist.Id
    $subscription = Set-AzContext -Subscription $subID | select Name
    $subscription
    if ($subscription -match "329f6ddd-8003-4747-b6da-6970b4afbc23")
        {
            Mav_Express
        }
        elseif ($subscription -match "33533742-27fe-482c-acb7-f904ae10b8f1")
        {
            OIT_WVD
        }
        elseif ($subscription -match "e3e87aa8-384f-4cef-a83d-84b1a066c306")
        {
            OIT_IO_Administration
        }
        elseif ($subscription -match "c4b34148-c5fb-4664-b736-0c1911f1ef3f")
        {
            Network_Operations
        }
        elseif ($subscription -match "697e3b15-da95-4101-a49d-198676e76111")
        {
            Identity_Automation
        }
        elseif ($subscription -match "a2600b75-bb30-4c7c-9f23-4ebb73b96ef2")
        {
            Enterprise_Data_Services
        }
        elseif ($subscription -match "2ac9b0d6-f26a-4f08-b39f-6d5de35ecc72")
        {
            Classroom_Support_Services
        }
        elseif ($subscription -match "2fc17d3f-d241-4c31-af43-24d92d09d773")
        {
            Property_Management_Operating
        }
        elseif ($subscription -match "ff8b68a0-360b-403c-a4bf-f255c2154825")
        {
            Student_Orientation_Programs
        }
        elseif ($subscription -match "e217e95a-94e5-4585-8491-5056b9fd7d5c")
        {
            Instructional_and_Advising_CE
        }
        elseif ($subscription -match "b880b9cb-265f-42da-b29b-50c2625a0650") 
        {
            SSW_Professional_Development  
        }
        elseif ($subscription -match "8c89db57-8954-4d64-bac7-e4165aad4cb6")
        {
            University_Analytics_M+O 
        }
        elseif ($subscription -match "c0e9e099-a39f-4860-94a7-32be365e2999")
        {
            OIT_Application_Development
        }
        elseif ($subscription -match "041de4d7-bbbe-43bd-9d12-e7c7b28744e0")
        {
            Startup-PRV-Liwei_Zhang
        }
        elseif ($subscription -match "af274c15-c83f-4024-a202-9dd499461b4e")
        {
            Campus_Recreation
        }
        elseif ($subscription -match "085f486a-47bd-4912-89e4-5669ae8142b4")
        {
            Intercollegiate_Athletics_ADMI
        }
        elseif ($subscription -match "8e05fcfb-2947-4b40-a708-606a0b8d0663")
        {
            College_Park_Center
        }
        elseif ($subscription -match "4e37870e-4a44-4dba-8143-dafd8162c436")
        {
            Civil_Engineering
        }
        else
        {

            $AzVMs = Get-AzVM 
            $VMs = $AzVMs | Where-Object {($_.ResourceGroupName -notmatch "test") -and ($_.ResourceGroupName -notmatch "development") -and ($_.StorageProfile.OsDisk.OsType -eq "Windows")}
            $VMs
            $i = 0 #This variable is needed to identify the specific values within the variable that contains the list of VMs

            #Starts looping through each VM on the list
            foreach ($VM in $VMs) 
            {
                Restart-AzVM -Name ($VMs.name[$i]) -ResourceGroupName ($vms.resourcegroupname[$i]) -NoWait -Verbose
                $i++

            }
        }
}


# Stop logging
Stop-transcript




