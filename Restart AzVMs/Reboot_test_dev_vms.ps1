<############################################################################################
The functions below have been created as a workaround for the following scenario. If a 
subscription contains only one VM that fits within the Windows test/dev resource group parameters, 
then it results in an error during the For loop. Until the error is resolved, the workaround 
is to use these functions to restart the VM individually instead of using the For loop.
#>

function Identity_Automation #This subscription contains azdcwapp03 & azdcwapp04
{
    Restart-AzVM -Name azhwwapt01 -ResourceGroupName utarlingtonautomation-orchestration-testrg -NoWait -Verbose
}

function Property_Management_Operating
{
    Restart-AzVM -Name assetswapt1 -ResourceGroupName inventorymanagement_test_rg -NoWait -Verbose
}

function Enterprise_Development_Admin
{
    Restart-AzVM -Name ace-dedwapt01 -ResourceGroupName aceweb_test_rg -NoWait -Verbose
}

function Student_Orientation_Programs
{
    Restart-AzVM -Name vzenapptst -ResourceGroupName visualzen_test_rg -NoWait -Verbose
}

#Start logging
Start-transcript 'C:\reboot_test_dev_vms.txt'

#Gather the list of subscriptions that start with "340604" and "340502"
$subs = Get-AzSubscription
$sublists = $subs | Where-Object {($_.Name -like "340604*") -or ($_.Name -like "340502*")}

#Starts looping through each subscription 
foreach ($sublist in $sublists) 
{
    $subID = $sublist.Id
    $subscription = Set-AzContext -Subscription $subID | select Name
    $subscription
    if ($subscription -match "697e3b15-da95-4101-a49d-198676e76111")
        {
            Identity_Automation
        }
        elseif ($subscription -match "2fc17d3f-d241-4c31-af43-24d92d09d773")
        {
            Property_Management_Operating
        }
                elseif ($subscription -match "3a4efad0-4000-4cd7-a775-ab814ec17430")
        {
            Enterprise_Development_Admin
        }
                elseif ($subscription -match "ff8b68a0-360b-403c-a4bf-f255c2154825")
        {
            Student_Orientation_Programs
        }
        else
        {
            $AzVMs = Get-AzVM 
            $VMs = $AzVMs | Where-Object {($_.ResourceGroupName -like "*test*") -or ($_.ResourceGroupName -like "*development*") -and ($_.StorageProfile.OsDisk.OsType -eq "Windows")}
    
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

