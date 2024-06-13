function Show-Menu
{
    param (
        [string]$Title = 'Server Type'
    )
    Clear-Host
    Write-Host "Server Type"
    
    Write-Host "1: Press '1' for Application (app)."
    Write-Host "2: Press '2' for Web (web)."
    Write-Host "2: Press '3' for Database (db)."
    Write-Host "2: Press '4' for Report (rpt)."
    Write-Host "2: Press '5' for Agent (agt)."
    Write-Host "3: Press '6' to quit."
}

 Show-Menu –Title 'Server Type'
 $selection = Read-Host "Please make a selection"
 switch ($selection)
 {
       '1' {
           $app = 'app'
         Write-Host $app
     } '2' {         
            $web = 'web'
         Write-Host $web
     } '3' {   
            $db = 'db'
         Write-Host $db
     } '4' {
            $rpt = 'rpt'
         Write-Host $rpt
     } '5' {         
            $agt = 'agt'
         Write-Host $agt
     }
       '6' {
         return
     }
 }



