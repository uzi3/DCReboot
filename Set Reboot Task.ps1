$Data=Import-csv C:\scripts\EMEA_reboot.csv
foreach ($i in $Data)
{
$Hostname=$i.Hostname
$Day=$i.Day
$Time=$i.Time


Write-host `n `n "Processing $i"
Schtasks /S "$Hostname" /CREATE /RU SYSTEM /TN "Patch Compliance Restart" /SC WEEKLY /D "$Day" /ST "$Time" /F /TR "Powershell.exe -executionpolicy unrestricted -nologo -file C:\Scripts\PatchTuesdayReboot.ps1"
}


