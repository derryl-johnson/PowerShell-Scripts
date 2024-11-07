
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









<# This will elevate the current user privilege to administrator
$currentUser = [System.Security.Principal.WindowsIdentity]::GetCurrent()
$currentUserPrincipal = new-object System.Security.Principal.WindowsPrincipal($currentUser)
if (! $currentUserPrincipal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator))
{
    $newProcess = new-object System.Diagnostics.ProcessStartInfo "PowerShell";
    $newProcess.Arguments = $myInvocation.MyCommand.Definition;
    $newProcess.Verb = "runas";
    [System.Diagnostics.Process]::Start($newProcess);
    exit;
}

#>





<#
# Set variables to indicate value and key to set
$RegistryPath = 'HKCU:\Software\Spoon\SandboxCacheTest'
$Name         = 'Test'
$Value        = '10'

# Create the key if it does not exist
If (-NOT (Test-Path $RegistryPath)) 
    {
      New-Item -Path $RegistryPath -Force | Out-Null
    }  

# Now set the value
New-ItemProperty -Path $RegistryPath -Name $Name -Value $Value -PropertyType DWORD -Force 


<# 
# Define the registry path and value name
$RegistryPath = "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU"
$ValueName = "AUOptions"
$NewValue = 3 #Auto download and notify for install 

# Check if the registry key exists, create it if it doesn't
if (-NOT (Test-Path $RegistryPath)) 
    {
        New-Item -Path $RegistryPath -Force | Out-Null
    }

# Set the registry value
Set-ItemProperty -Path $RegistryPath -Name $ValueName -Value $NewValue -Type DWord

#>