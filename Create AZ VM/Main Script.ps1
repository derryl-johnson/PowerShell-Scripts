### This will allow you to input the subscription information
function CostCenter_Man
{
    $costcenter = Read-Host "Enter new cost center number"
    do {
        if ($costcenter.Length -ne 6)
            {
                Write-Output "Cost center must be six numbers." 
                $costcenter = Read-Host "Enter new cost center number"
            }
        }
    until ($costcenter.Length -ne 6)


    Write-Output $costcenter
}


function DeptCode_Man
{
    $departmentcodenumber = Read-Host "Enter new department code number"
    if ($departmentcodenumber.Length -ne 6)
    {
        Write-Output "Departmet code must be six numbers. Please enter department code number"
    }
    else {
    Write-Output $departmentcodenumber
        }
}


function CCName_Man
{
    $costcentername = Read-Host "Enter new cost center name"
    Write-Output $costcentername
}

function Show-Menu
{
    Clear-Host
    Write-Host "Subscription Information`n"

    Write-Host "1: Press '1' for New."
    Write-Host "2: Press '2' for Existing."
    Write-Host "3: Press 'Q' to quit."
}

 Show-Menu 
 $selection = Read-Host "Please make a selection"
 switch ($selection)
 {
     '1' {
           Clear-Host
           $costCenter = CostCenter_Man
           $departmentCodeNumber = DeptCode_Man
           $costCenterName = CCName_Man
           $selfsupport = 'True'
                } 
      '2' {
         $SubscriptionId = (Get-AzSubscription | Out-GridView -PassThru -Title 'Select Subscription')
         $costcenter = $SubscriptionId.name.Substring(0,6)
         $departmentCodeNumber = $SubscriptionId.name.Substring(7,6)
         $costCenterName = $SubscriptionId.name.Substring(14)
         $selfsupport = 'False'
                }
      'Q' {
            Clear-Host
            return
            }
      
   }

#This provides input for the application name
function AppName_Man 
{
    Clear-Host
    Write-Host "Application Name`n"
    $appName = Read-Host "Enter new application name"
    if ( $null )
            {
                $appName = 'Adobe'
            }
    Write-Output $appName  
}

$applicationName = AppName_Man 

#This provides input for the server operating system
function ServerOS_Man
{
    param (
        [string]$Title = 'My Menu'
    )
    Clear-Host
    Write-Host "Operating System`n"

    Write-Host "1: Press '1' for Windows."
    Write-Host "2: Press '2' for Oracle."
    Write-Host "3: Press '3' for Red Hat."
    Write-Host "4: Press '4' for Ubuntu."
    Write-Host "5: Press 'Q' to quit."
}

ServerOS_Man -Title 'Operating System'
 $selection = Read-Host "Please make a selection"
 switch ($selection)
{
     '1' {
          $serveros = 'windows'
          } 
     '2' {
          $serveros = 'oracle19'
          } 
     '3' {
          $serveros = 'rhel8'
          }
     '4' {
          $serveros = 'ubuntu'
          }
     'q' {
          Clear-Host
          return
          }
}

#This provides input for the secondary disk size
function DiskSize_Man
{
    Clear-Host
    Write-Host "Disk Size`n"
    $disk_size = Read-Host "Enter the secondary disk size (GB). Press Enter for default of 50GB"
    if ($disk_size -eq "") 
        {
            $disk_size = 50
        }
    Write-Output $disk_size
}

$diskSize = DiskSize_Man

#This provides input for the environment type
function EnviroType_Man
{
    param (
        [string]$Title = 'My Menu'
    )
    Clear-Host
    Write-Host "Environment Type`n"

    Write-Host "1: Press '1' for Production."
    Write-Host "2: Press '2' for Test."
    Write-Host "3: Press '3' for Development."
    Write-Host "4: Press 'Q' to quit."
}

 EnviroType_Man –Title 'Environment Type'
 $selection = Read-Host "Please make a selection"
 switch ($selection)
 {
     '1' {
           $environmentType = 'Production'
     } '2' {
         $environmentType = 'Test'
     } 
       '3' {
          $environmentType = 'Development'
          }
     'q' {
          Clear-Host
          return
          }
 }

#This provides input for the server type
function ServerType_Man
{
    param (
        [string]$Title = 'My Menu'
    )
    Clear-Host
    Write-Host "Server Type`n"

    Write-Host "1: Press '1' for Application."
    Write-Host "2: Press '2' for Web."
    Write-Host "3: Press '3' for Database."
    Write-Host "3: Press '4' for Report."
    Write-Host "3: Press '5' for Agent."
    Write-Host "3: Press '6' for Other."
    Write-Host "7: Press 'Q' to quit."
}

 ServerType_Man –Title 'Server Type'
 $selection = Read-Host "Please make a selection"
 switch ($selection)
 {
     '1' {
           $serverType = 'app'
     } '2' {
         $serverType = 'web'
     } 
       '3' {
          $serverType = 'db'
          }
	'4' {
          $serverType = 'rpt'
          }
	'5' {
          $serverType = 'agt'
          }
	'6' {
	  $serverType = Read-Host "Enter the server type"
          }
     'q' {
          Clear-Host
          return
          }
 }

#This provides input for the server size
function serverSize_Man
{
    param (
        [string]$Title = 'My Menu'
    )
    Clear-Host
    Write-Host "Server Size`n"

    Write-Host "1: Press '1' for [Standard_D2s_v4] 2 vcpu, 8 GiB memory (default)"
    Write-Host "2: Press '2' for [Standard_D4s_v4] 4 vcpu, 16 GiB memory (medium)"
    Write-Host "3: Press '3' for [Standard_D8s_v4] 8 vcpu, 32 GiB memory (large)"
    Write-Host "4: Press '4' for [Standard_D16s_v4] 16 vcpu, 64 GiB memory (XL)`n"
    
    Write-Host "Memory Optimized for Oracle`n"
    Write-Host "5: Press '5' for [Standard_E2s_v4] 2 vcpu, 16 GiB memory (default)"
    Write-Host "6: Press '6' for [Standard_E4s_v4] 4 vcpu, 32 GiB memory (medium)"
    Write-Host "7: Press '7' for [Standard_E8s_v4] 8 vcpu, 64 GiB memory (large)"
    Write-Host "8: Press '8' for [Standard_E16s_v4] 16 vcpu, 128 GiB memory (XL)`n"

    Write-Host "9: Press 'Q' to quit."
}

 serverSize_Man –Title 'Server Size'
 $selection = Read-Host "Please make a selection"
 switch ($selection)
 {
     '1' {
           $serverSize = 'Standard_D2s_v4'
     } '2' {
         $serverSize = 'Standard_D4s_v4'
     } 
       '3' {
          $serverSize = 'Standard_D8s_v4'
          }
       '4' {
          $serverSize = 'Standard_D16s_v4'
          }
     '5' {
           $serverSize = 'Standard_E2s_v4'
     } '6' {
         $serverSize = 'Standard_E4s_v4'
     } 
       '7' {
          $serverSize = 'Standard_E8s_v4'
          }
       '8' {
          $serverSize = 'Standard_E16s_v4'
          }
     'q' {
          Clear-Host
          return
          }
 }

#This provides input for the VNET range
function VnetRange_Man
{
    Clear-Host
    Write-Host "VNET IP Range`n"
    $vnet_range = Read-Host "Enter VNET IP range (ex. 10.208.8.64/26)"
    Write-Output $vnet_range
}

$vnetRange = VnetRange_Man

#This provides input for the default subnet range
function SubnetDefault_Man
{
    Clear-Host
    Write-Host "Default Subnet Range`n"
    $subnetRange = Read-Host "Enter default subnet range (ex. 10.208.8.64/27)"
    Write-Output $subnetRange
}

$subnetRangeDefault = SubnetDefault_Man

#This provides input for the subnet bastion range
function SubnetBastion_Man
{
    Clear-Host
    Write-Host "Subnet Bastion Range`n"
    $subnetBastion = Read-Host "Enter subnet bastion range (ex. 10.208.8.96/27)"
    Write-Output $subnetBastion
}

$subnetRangeBastion = SubnetBastion_Man

#This provides input for the service request number
function ServiceNow_Man
{
    Clear-Host
    Write-Host "ServiceNow Request number`n"
    $request_number = Read-Host "Enter service request number"
    Write-Output $request_number
}

$requestNumber = ServiceNow_Man

#This provides input to know if the server will be self supported
#function selfsupport_man
{
    param (
        [string]$Title = 'My Menu'
    )
    Clear-Host
    Write-Host "Will the server be self supported?`n"

    Write-Host "1: Press '1' for Yes."
    Write-Host "2: Press '2' for No."

}
 
 selfsupport_Man –Title 'Self Supported'
 #$selection = Read-Host "Please make a selection"
 switch ($selection)
 {
     '1' {
           $selfsupport = 'True'
     } '2' {
         $selfsupport = 'False'
     } 

 }

 ### This is the summary before execution
 function Recap
{
    param (
        [string]$Title = 'Overview'
    )
    Clear-Host
    Write-Host "Is the information correct?`n"

    Write-Host "Cost Center: $costcenter"    
    Write-Host "Department code: $departmentcodenumber"
    Write-Host "Cost Center Name: $costcentername"
    Write-Host "Application Name: $applicationName"
    Write-Host "Server Operating System: $serverOS"
    Write-Host "Server Disk Size: $diskSize"
    Write-Host "Environment Type: $environmentType"
    Write-Host "Server Type: $serverType"
    Write-Host "Server Size: $ServerSize"
    Write-Host "VNET IP Range: $VnetRange"
    Write-Host "Subnet Default Range: $subnetRangeDefault"
    Write-Host "Subnet Bastion Range: $subnetRangeBastion"
    Write-Host "ServiceNow Request Number: $requestNumber"
    Write-Host "Self Support: $selfsupport`n"


    Write-Host "1: Press '1' for Yes."
    Write-Host "2: Press '2' for No."
    
}
#If the selection is No, then the code will enter the do loop below
do{

 Recap –Title 'Recap'
 $selection = Read-Host "Please make a selection"
 switch ($selection)
 {
     '1' {
           Clear-Host
           return
     } '2' {
         Correction
     } 
 }




 # This is the option to make corrections

 function Correction
{
    param (
        [string]$Title = 'Make Correction'
    )
    Clear-Host
    Write-Host "What corrections would you like to make?`n"
    
    Write-Host "1: Cost center number"
    Write-Host "2: Department code number"
    Write-Host "3: Cost center name"
    Write-Host "4: Application Name"
    Write-Host "5: Server Operating System"
    Write-Host "6: Server Disk Size"
    Write-Host "7: Environment Type"
    Write-Host "8: Server Type"
    Write-Host "9: Server Size"
    Write-Host "10: VNET IP Range"
    Write-Host "11: Subnet Default Range"
    Write-Host "12: Subnet Bastion Range"
    Write-Host "13: ServiceNow Request Number"
    Write-Host "14: Self Support"
}


Correction –Title 'Correction'
 $correct = Read-Host "Please make a selection"
 switch ($correct)
 {
     '1' {
          Clear-Host
          $costcenter = Read-Host "Cost Center`n`n1: Press '1' for New.`n2: Press '2' for Existing.`nPlease make a selection"
          switch ($costcenter)
            {
             '1' {
                   Clear-Host
                   $costcenter = Read-Host "Enter new cost center number"
                  } 
              '2' {
                 $SubscriptionId = (Get-AzSubscription | Out-GridView -PassThru -Title 'Select Subscription')
                 $costcenter = $SubscriptionId.name.Substring(0,6)
                  } 
             }

          } 

     '2' {
         Clear-Host
         $departmentCodeNumber = Read-Host "Department Code Number`n`n1: Press '1' for New.`n2: Press '2' for Existing.`nPlease make a selection"
         switch ($departmentCodeNumber)
         {
                     '1' {
                           Clear-Host
                           $departmentCodeNumber = Read-Host "Enter new department code number"
                                } 
                      '2' {
                         $SubscriptionId = (Get-AzSubscription | Out-GridView -PassThru -Title 'Select Subscription')
                         $departmentCodeNumber = $SubscriptionId.name.Substring(7,6)
                     } 
           }
        } 
     '3' {
          Clear-Host
          $costCenterName = Read-Host "Cost Center Name`n`n1: Press '1' for New.`n2: Press '2' for Existing.`nPlease make a selection"
             switch ($costCenterName)
             {
                         '1' {
                               Clear-Host
                               $costCenterName = Read-Host "Enter new department code number"
                                    } 
                          '2' {
                             $SubscriptionId = (Get-AzSubscription | Out-GridView -PassThru -Title 'Select Subscription')
                             $costCenterName = $SubscriptionId.name.Substring(14)
                             }
              } 
        }

     '4' {
         $applicationName = AppName_Man
        } 
     '5' {
                          Clear-Host
                $serverOS = Read-Host "Operating System`n`n1: Press '1' for Windows.`n2: Press '2' for Oracle.`n3: Press '3' for Red Hat.`n4: Press '4' for Ubuntu.`nPlease make a selection"
                switch ($serverOS)
                     {
                         '1' {
                               $serveros = 'windows'
                         } '2' {
                             $serveros = 'oracle19'
                         } 
                           '3' {
                              $serveros = 'rhel8'
                              }
                           '4' {
                              $serveros = 'ubuntu'
                              }
                    } 
            }
           
          
     '6' {
         $diskSize = DiskSize_Man
        } 
     '7' {
                          Clear-Host
                $environmentType = Read-Host "Environment Type`n`n1: Press '1' for Production.`n2: Press '2' for Test.`n3: Press '3' for Development.`nPlease make a selection"
                switch ($environmentType)
                     {
                         '1' {
                               $environmentType = 'Production'
                         } '2' {
                             $environmentType = 'Test'
                         } 
                           '3' {
                              $environmentType = 'Development'
                              }
                     }
          } 

     '8' {
                         Clear-Host
                                $serverType = Read-Host "Server Type`n`n1: Press '1' for Application.`n2: Press '2' for Web.`n3: Press '3' for Database.`n4: Press '4' for Report.`n5: Press '5' for Agent.`n6: Press '6' for Other.`nPlease make a selection"
                                switch ($serverType)
                                      {
                     '1' {
                           $serverType = 'app'
                     } '2' {
                         $serverType = 'web'
                     } 
                       '3' {
                          $serverType = 'db'
                          }
	                '4' {
                          $serverType = 'rpt'
                          }
	                '5' {
                          $serverType = 'agt'
                          }
	                '6' {
	                  $serverType = Read-Host "Enter the server type"
                          }
                 }
        } 
     '9' {
                         Clear-Host
                                $serversize = Read-Host "Server Size`n`n1: Press '1' for [Standard_D2s_v4] 2 vcpu, 8 GiB memory (default)`n2: Press '2' for [Standard_D4s_v4] 4 vcpu, 16 GiB memory (medium)`n3: Press '3' for [Standard_D8s_v4] 8 vcpu, 32 GiB memory (large)`n4: Press '4' for [Standard_D16s_v4] 16 vcpu, 64 GiB memory (XL)`n5: Press '5' for [Standard_E2s_v4] 2 vcpu, 16 GiB memory (default)`n6: Press '6' for [Standard_E4s_v4] 4 vcpu, 32 GiB memory (medium)`n7: Press '7' for [Standard_E8s_v4] 8 vcpu, 64 GiB memory (large)`n8: Press '8' for [Standard_E16s_v4] 16 vcpu, 128 GiB memory (XL)`nPlease make a selection"
                                switch ($serversize)
                                       {
                                         '1' {
                                               $serversize = 'Standard_D2s_v4'
                                         } '2' {
                                             $serversize = 'Standard_D4s_v4'
                                         } 
                                           '3' {
                                              $serversize = 'Standard_D8s_v4'
                                              }
                                           '4' {
                                              $serversize = 'Standard_D16s_v4'
                                              }
                                         '5' {
                                               $serversize = 'Standard_E2s_v4'
                                         } '6' {
                                             $serversize = 'Standard_E4s_v4'
                                         } 
                                           '7' {
                                              $serversize = 'Standard_E8s_v4'
                                              }
                                           '8' {
                                              $serversize = 'Standard_E16s_v4'
                                              }
                                     }          } 

     '10' {
         Clear-Host
         $vnetRange = VnetRange_Man
        } 
     '11' {
          $subnetRangeDefault = SubnetDefault_Man
          } 
     '12' {
          $subnetRangeBastion = SubnetBastion_Man
          } 

     '13' {
         $requestNumber = ServiceNow_Man
        } 
     
     '14' {
         Clear-Host
         $selfsupport = Read-Host "Will the server be self supported?`n`n1: Press '1' for True.`n2: Press '2' for False.`nPlease make a selection"
             switch ($selfsupport)
             {
                         '1' {
                               $selfsupport = 'True'
                                    } 
                          '2' {
                             $selfsupport = 'False'
                             }
              } 
           }
 }
 
Recap
}
until ($selection -eq '1')