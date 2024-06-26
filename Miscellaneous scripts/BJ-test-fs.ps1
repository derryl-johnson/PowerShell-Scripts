$deptshortname = "BJ-test"
$stgaccount = "filesync1"
$deptname = "OIT SystemOps"
$drvletter = "o"
$stgacclongname = "$stgaccount.file.core.windows.net"
$drivedescription = "$stgaccount-fs"
$rootname = "\\$stgacclongname\$deptshortname-fs"
 
# $stgaccount
write-host "Connecting ""$deptname"" file share"
write-host "Rootname $rootname"
 
$hkcupath = "HKCU:\Network\$drvletter"
 
if (get-psdrive -Name $drvletter -ErrorAction SilentlyContinue)
{
  Write-Host ""
  Write-host "`tDrive $drvletter is already mapped."
  Write-Host ""
  Pause "Press enter to exit"
  Exit
} else {
  write-host "Storage account: $stgacclongname"
  $connectTestResult = Test-NetConnection -ComputerName $stgacclongname -Port 445
  if ($connectTestResult.TcpTestSucceeded) {
    write-host "Testing to $stgacclongname was successful!"
    $creds = Get-Credential -Message "UTA Email address and Netid password"
    # Mount the drive
    write-host "Lets mount drive $drvletter"
    New-PSDrive -Name $drvletter -Credential $creds -PSProvider FileSystem -Root $rootname -Persist -Scope Global -Description $drivedescription | Out-Null
    if (test-path $hkcupath) {
      set-ItemProperty -Path $hkcupath -name 'DeferFlags' -Value '4'
      set-ItemProperty -Path $hkcupath -name 'ConnectionType' -Value '1'
    } else {
      Write-Error -Message "Registry entries not changed."
      Pause "Press enter to continue"
    }
  } else {
    Write-Error -Message "Unable to reach the Azure storage account via port 445. Check to make sure your organization or ISP is not blocking port 445, or use Azure P2S VPN, Azure S2S VPN, or Express Route to tunnel SMB traffic over a different port."
    Pause "Press enter to continue"
  }
}
if (get-psdrive -Name $drvletter -ErrorAction SilentlyContinue)
{
  Write-Host "Drive $drvletter has been mapped successfully"
  Start-Sleep 5
} else {
  Write-Host "Drive was not mapped!  Verify you are using your Azure credentials."
  Pause "Press enter to continue"
}
