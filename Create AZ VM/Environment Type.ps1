function Show-Menu
{
    param (
        [string]$Title = 'Environment Type'
    )
    Clear-Host
    Write-Host "Environment Type"
    
    Write-Host "1: Press '1' for Production."
    Write-Host "2: Press '2' for Test."
    Write-Host "3: Press '3' for Development."
    Write-Host "4: Press '4' to quit."
}

 Show-Menu –Title 'Environment Type'
 $selection = Read-Host "Please make a selection"
 switch ($selection)
 {
     '1' {
           $new = 'Production'
           Write-Host $new
     } '2' {
           $new = 'Test'
           Write-Host $new
     }'3' {
           $new = 'Development'
           Write-Host $new
     } 
     '4' {
         return
     }
 }