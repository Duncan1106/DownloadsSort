# @Author: Duncan1106, Github
# Sorter with options to enable or disable different
# Extensions to sort in the different Folders

# check for admin priviledges
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

# ==================== SORTER ==================== #

Write-Output "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
Write-Output "~~~~~~~~~~~~~~~ Downloads Sorter ~~~~~~~~~~~~~~~"
Write-Output "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
Write-Output "~~~~~~~~~~~~~~~ by Duncan1106 ~~~~~~~~~~~~~~~~~~"
Write-Output "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

Write-Debug "declared the different folders"
# Downloadsfolder
$DownloadsFolderPath = (New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path

# Programmsfolder
$ProgrammsFolderPath = [Environment]::GetFolderPath("MyDocuments") + "\Programms\"

# Documentsfolder
$DocumentsFolderPath = [Environment]::GetFolderPath("MyDocuments") + "\Downloaded\"

# APKsfolder
$ApkFolderPath = $ProgrammsFolderPath + "\APKs"

# Videofolder
$VideosFolderPath = [Environment]::GetFolderPath("MyVideos") + "\Downloaded\"

# Musicfolder
$MusicFolderpath = [Environment]::GetFolderPath("MyMusic") + "\Downloaded\"

# Picturefolder
$PictureFolderPath = [Environment]::GetFolderPath("MyPictures") + "\Downloaded\"

# get all Files in Downloadsfolder
$DownloadsFiles = Get-ChildItem -Path $DownloadsFolderPath -File

# actual Sorter
Function sorter{
    Write-Output "Include programms? y or n"
    $programms = Read-Host "Input: "
    Write-Output "Include documents? y or n"
    $documents = Read-Host "Input: "
    Write-Output "Include apks? y or n"
    $apks = Read-Host "Input: "
    Write-Output "Include videos? y or n"
    $videos = Read-Host "Input: "
    Write-Output "Include music? y or n"
    $music = Read-Host "Input: "
    Write-Output "Include pictures? y or n"
    $pictures = Read-Host "Input: "
    Write-Output "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

    foreach ($File in $DownloadsFiles) {
        Try{
            $FileExtension = [System.IO.Path]::GetExtension($File).Split('.')[1]

            if ($FileExtension -cmatch "exe" -or $FileExtension -cmatch "msi") {
                if ($programms -cmatch "y" -or $programms -cmatch "Y") {
                    Move-Item -Path $File.FullName -Destination $ProgrammsFolderPath
                    Write-Output "Succesfully moved $($File.FullName) to $ProgrammsFolderPath"
                    Write-Output "Sorted Programms`n"
                }
            }
            if ($FileExtension -cmatch "docx" -or $FileExtension -cmatch "doc" -or $FileExtension -cmatch "pdf") {
                if ($documents -cmatch "y" -or $documents -cmatch "Y") {
                    Move-Item -Path $File.FullName -Destination $DocumentsFolderPath
                    Write-Output "Succesfully moved $($File.FullName) to $DocumentsFolderPath "
                    Write-Output "Sorted Programms`n"
                }
            }
            if ($FileExtension -cmatch "apk" -or $FileExtension -cmatch "apks") {
                if ($apks -cmatch "y" -or $apks -cmatch "Y") {
                    Move-Item -Path $File.FullName -Destination $ApkFolderPath
                    Write-Output "Succesfully moved $($File.FullName) to $ApkFolderPath"
                    Write-Output "Sorted APKs`n"
                }
            }
            if ($FileExtension -cmatch "mp4" -or $FileExtension -cmatch "m4v" -or $FileExtension -cmatch "mkv") {
                if ($videos -cmatch "y" -or $videos -cmatch "Y") {
                    Move-Item -Path $File.FullName -Destination $VideosFolderPath
                    Write-Output "Succesfully moved $($File.FullName) to $VideosFolderPath"
                    Write-Output "Sorted Videos`n"
                }
            }
            if ($FileExtension -cmatch "mp3" -or $FileExtension -cmatch "wav" -or $FileExtension -cmatch "acc" -or $FileExtension -cmatch "mid" -or $FileExtension -cmatch "m4a"  ){
                if ($music -cmatch "y" -or $music -cmatch "Y") {
                    Move-Item -Path $File.FullName -Destination $MusicFolderpath
                    Write-Output "Succesfully moved $($File.FullName) to $MusicFolderPath"
                    Write-Output "Sorted Music`n"
                }
            }
            if ($FileExtension -cmatch "jpg" -or $FileExtension -cmatch "png" -or $FileExtension -cmatch "xcf"){
                if ($pictures -cmatch "y" -or $pictures -cmatch "Y") {
                    Move-Item -Path $File.FullName -Destination $PictureFolderPath
                    Write-Output "Succesfully moved $($File.FullName) to $PictureFolderPath"
                    Write-Output "Sorted Pictures`n"
                }
            }        
        }
        Catch {
            Write-Output ""
            Write-Output $_.Exception.Message -ForegroundColor Red
            Write-Output $_.ScriptStackTrace
            Write-Output ""
        }
    }
    Write-Output "`nCompleted sorting the different file types in their own folder`n" -ForegroundColor Green
}

# ==================== GUI ==================== #

## visable Menu for user
Write-Output "1: Enter 1 to sort the Downloads Folder"
Write-Output "Q: Enter Q to quit."

$user_input = (Read-Host "Please decide: ").ToUpper()

switch ($user_input){
    '1' {sorter}
    'Q' {Write-Output "The script has been terminated" -BackgroundColor Red -ForegroundColor White}
    Default {Write-Output "Your selection = $user_input, is not valid. Please try again." -BackgroundColor Red -ForegroundColor White}
}
pause
