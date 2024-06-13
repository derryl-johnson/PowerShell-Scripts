function Show-Menu
{
    param (
        [string]$Title = 'Disk Size'
    )
    Clear-Host
    Write-Host "Disk Size"
    
    Write-Host "1: Press '1' for custom size."
    Write-Host "2: Press '2' for default size (50GB)."
    Write-Host "3: Press '3' to quit."
}

 Show-Menu –Title 'Disk Size'
 $selection = Read-Host "Please make a selection"
 switch ($selection)
 {
     '1' {
           $new = Read-Host "Enter custom disk size (in GB)"
           Write-Host $new
     } '2' {
         $disksize = 50 
         Write-Host $disksize
     } '3' {
         return
     }
 }