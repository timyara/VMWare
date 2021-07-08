$datacenter=get-datacenter
$cluster=get-cluster
$vms=Get-VM
$StatsOnServer= New-Object System.Collections.ArrayList
$datastore0=""
$datastore1=""
$vmhost0=""
$vmhost1=""
foreach($vm in $vms) {
$tempobject=$vm | Get-HardDisk 

 if($tempobject.FileName.count -gt 1){
       $Datastore0=$tempobject.FileName[0].Substring(19,13)
       $Datastore1=$tempobject.FileName[1].Substring(19,13)
       $vmhost0=$tempobject.FileName[0].Substring(1,13)
       $vmhost1=$tempobject.FileName[1].Substring(1,13)
       }
       else{
       $Datastore0=$tempobject.FileName.Substring(19,13)
       $Datastore1="NoDisk"
       $vmhost0=$tempobject.FileName.Substring(1,13)
       $vmhost1="NoHost"
       }
[void]$StatsOnServer.add([PSCustomObject] @{  
       Name=$vm.Name
        Datastore0=$datastore0
        Datastore1=$datastore1
        VMHost0=$vmhost0
        VMHost1=$vmhost1
        })
}

 $StatsOnServer | export-csv C:\SAPFGL\drivestats.csv -NoTypeInformation -Force
 .\drivestats.csv
