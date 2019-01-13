Summary:
Use these scripts to automate domain controller restart after patching Tuesday.


Description:
This script will force restart the DC if the execution date is between second Tuesday and third Tuesday. 
If the execution date is between third Tuesday and fourth Tuesday, script will check if the DC requires the reboot. If required, DC will get reboot. If not, then the script will exit. 
Similar is the case if the execution date is between fourth and fifth Tuesday.


Instructions:
1) Enter the details of the domain controllers in serverlist.csv file. Here day and time represents on which day of the week and which time of the day you want to reboot the server. Place this file in C drive from where you want to execute the script.
2) Keep PatchTuesdayReboot.ps1 in C drive of a domain controller from where other domain controllers are accessible (usually PDC)
3) Execute CopyReboot.ps1 which will copy PatchTuesdayReboot.ps1 in C drive of all other domain controller's C drive
4) Execute SetRebootTask.ps1 which will schedule restart task every week and will act according to the condition.
