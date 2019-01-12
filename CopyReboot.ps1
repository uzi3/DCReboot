Import-Module activedirectory
$DCs=Get-ADDomainController -Filter * | select -ExpandProperty name | sort

foreach ($i in $DCs)
{
Write-host `n `n "Processing $i"
Copy-Item -Path C:\PatchTuesdayReboot.ps1 -Destination \\$i\c$\PatchTuesdayReboot.ps1 -Force
}


