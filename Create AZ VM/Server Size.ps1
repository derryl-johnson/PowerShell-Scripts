function Show-Menu
{
    param (
        [string]$Title = 'Server Size'
    )
    Clear-Host
    Write-Host "Server Size"
    
    Write-Host "1: Press '1' for New."
    Write-Host "2: Press '2' for Existing."
    Write-Host "3: Press '3' to quit."
}

 Show-Menu –Title 'Server Size'
 $selection = Read-Host "Please make a selection"
 switch ($selection)
 {
     '1' {
           $azvmsize = Read-Host "Enter server size"
           Write-Host $azmvsize
     } '2' {
         $azvmsize = (Get-AzVMSize -Location "southcentralus"  | Out-GridView -PassThru -Title 'Select Server Size')
         $servertype = $azvmsize.name
         Write-Host $servertype
     } '3' {
         return
     }
 }



