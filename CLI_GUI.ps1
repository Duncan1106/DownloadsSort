## Functions behind the menu items
Write-Host "~~~~~~~~~~GUI~~~~~~~~~~"
$ownPath = $args[0]
Write-Host $ownPath

Function checkOptions{
    Write-Host "Include programms? y or n"
    $programms = Read-Host "Input: "
    Write-Host "Include videos? y or n"
    $videos = Read-Host "Input: "
    Write-Host "Include music? y or n"
    $music = Read-Host "Input: "
    Write-Host "Include pictures? y or n"
    $pictures = Read-Host "Input: "
    
    $sorter = "$ownpath" + "SortDownloadsFolder.ps1"
    powershell.exe $sorter "$programms" "$videos" "$music" "$pictures"
}

## visable Menu for user
Write-Host "~~~~~~~~~~~~~~~~~~ Menu Title ~~~~~~~~~~~~~~~~~~" -ForegroundColor Cyan
Write-Host "1: Enter 1 to execute the versand and history script"
Write-Host "Q: Enter Q to quit."

$input = (Read-Host "Please make a selection").ToUpper()

switch ($input)
{
    '1' {checkOptions}    ### Input the name of the function you want to execute when 1 is entered
    'Q' {Write-Host "The script has been terminated" -BackgroundColor Red -ForegroundColor White}
    Default {Write-Host "Your selection = $input, is not valid. Please try again." -BackgroundColor Red -ForegroundColor White}
}
pause