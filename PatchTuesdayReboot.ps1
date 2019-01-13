Import-Module activedirectory

$hostname = (Get-ChildItem Env:\COMPUTERNAME).value
$name = (Get-ADComputer -Identity "$hostname" -Properties *).dnshostname

$FSMOCheck=Get-ADDomain | select infrastructuremaster, ridmaster, pdcemulator

$PDC=$FSMOCheck.pdcemulator
$RID=$FSMOCheck.ridmaster
$Infra=$FSMOCheck.infrastructuremaster




If (!(($PDC -eq $name) -or ($RID -eq $name) -or ($Infra -eq $name)))
{
    $PresentDate=Get-date
    $PresentDayOfMonth=($PresentDate).Day

    $FirstDateOfMonth=($PresentDate).AddDays(-$PresentDayOfMonth + 1)
    $FirstDayOfMonth=(($PresentDate).AddDays(-$PresentDayOfMonth + 1)).DayOfWeek


    If ($FirstDayOfMonth -eq "Sunday")
    {$FirstTuesday=($FirstDateOfMonth).AddDays(+2)}

    Elseif ($FirstDayOfMonth -eq "Monday")
    {$FirstTuesday=($FirstDateOfMonth).AddDays(+1)}

    Elseif ($FirstDayOfMonth -eq "Tuesday")
    {$FirstTuesday=$FirstDateOfMonth}

    Elseif ($FirstDayOfMonth -eq "Wednesday")
    {$FirstTuesday=($FirstDateOfMonth).AddDays(-1)}

    Elseif ($FirstDayOfMonth -eq "Thursday")
    {$FirstTuesday=($FirstDateOfMonth).AddDays(-2)}

    Elseif ($FirstDayOfMonth -eq "Friday")
    {$FirstTuesday=($FirstDateOfMonth).AddDays(-3)}

    Elseif ($FirstDayOfMonth -eq "Saturday")
    {$FirstTuesday=($FirstDateOfMonth).AddDays(-4)}

    $SecondTuesday = $FirstTuesday.AddDays(7)
    $ThirdTuesday = $FirstTuesday.AddDays(14)
    $FourthTuesday = $FirstTuesday.AddDays(21)
    $FifthTuesday = $FirstTuesday.AddDays(28)


    If ($PresentDate -lt $SecondTuesday)
    {
        exit
    }

    Elseif (($PresentDate -gt $SecondTuesday) -and ($PresentDate -lt $ThirdTuesday))
    {
       Restart-Computer -Force
    }

    Elseif (($PresentDate -gt $ThirdTuesday) -and ($PresentDate -lt $FourthTuesday))
    {
       $result=Test-path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired'
        If ($result -eq $true)
        {
            Restart-Computer -Force
        } 
        else 
        {
            exit
        }  
    }

    Elseif (($PresentDate -gt $FourthTuesday) -and ($PresentDate -lt $FifthTuesday))
    {
        $result=Test-path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired'
        If ($result -eq $true)
        {
            Restart-Computer -Force
        } 
        else 
        {
            Exit
        }
    }
}


else 
{
    exit
}
