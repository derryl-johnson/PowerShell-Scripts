
New-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate' -Name DisabledDualScan -Value 1 -PropertyType DWORD -Force 
New-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate' -Name TargetGroupEnabled -Value 1 -PropertyType DWORD -Force 
New-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate' -Name TargetGroup -Value 'PVH-NON-PROD' -PropertyType String -Force 
New-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate' -Name WUServer -Value 'http://vpvmawwsus001.ed.gov:8530' -PropertyType String -Force 
New-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate' -Name WUStatusServer -Value 'http://vpvmawwsus001.ed.gov:8530' -PropertyType String -Force 
New-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate' -Name UpdateServiceUrlAlternate -PropertyType String -Force 
New-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate' -Name SetProxyBehaviorForUpdateDetection -Value 0 -PropertyType DWORD -Force 

New-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU' -Name NoAutomaticUpdate -Value 0 -PropertyType DWORD -Force 
New-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU' -Name AUOptions -Value 3 -PropertyType DWORD -Force 
New-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU' -Name ScheduledInstallDay -Value 0 -PropertyType DWORD -Force 
New-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU' -Name ScheduledInstallTime -Value 0 -PropertyType DWORD -Force 
New-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU' -Name ScheduledInstallEveryWeek -Value 1 -PropertyType DWORD -Force 
New-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU' -Name UseWUServer -Value 1 -PropertyType DWORD -Force 

