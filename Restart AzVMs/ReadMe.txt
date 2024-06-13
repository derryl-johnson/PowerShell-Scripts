The scripts in this directory were created to restart Azure VMs after patches were installed using Azure Update Manager. Although Azure Update Manger has a feature to restart the VMs automatically, it was asked that the VMs would restart at the same time. Once the patches were completed within the maintenance window, the VMs had to be rebooted "manually".

The "Get" scripts was written as a proof of concept. Instead of rebooting the VMs, it was written to gather info on the VMs. The "Reboot" scripts performed the actual reboots.

For the script to work, you must already be logged into an existing Azure subscription. When the reboot script runs, it will gather and create a list of Azure subscriptions and filter the ones containing VMs. From there, it will take the Azure subscription list and connect to each one line by line. 

If the subscription ID matches a specific function, then it will execute that function. Many of the functions were created for specific reasons. If a subscription only contained one VM, then it will create an error that will cause the script to halt. Also, there were subscriptions that contained Linux VMs that did not need to be included in the reboot because they were being patched seperately using Puppet. To workaround these scenarios, the functions were written to reboot only the define VMs within that subscription. 

If the subscription ID does NOT match a function, then it will gather a list of all the VMs and loop through each one while telling it to reboot. Once completed, it will connect to the next subscription until it loops through each one on the list. 
