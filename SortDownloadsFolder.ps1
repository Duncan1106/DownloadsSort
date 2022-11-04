# @Author: Duncan1106, Github
# Sorter with options to enable or disable different
# Extensions to sort in the different Folders

# check for admin priviledges
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

# ==================== SORTER ==================== #

Write-Host "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
Write-Host "~~~~~~~~~~~~~~~ Downloads Sorter ~~~~~~~~~~~~~~~"
Write-Host "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
Write-Host "~~~~~~~~~~~~~~~ by Dsuncan1106 ~~~~~~~~~~~~~~~~~~"
Write-Host "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

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
    Write-Host "Include programms? y or n"
    $programms = Read-Host "Input: "
    Write-Host "Include documents? y or n"
    $documents = Read-Host "Input: "
    Write-Host "Include apks? y or n"
    $apks = Read-Host "Input: "
    Write-Host "Include videos? y or n"
    $videos = Read-Host "Input: "
    Write-Host "Include music? y or n"
    $music = Read-Host "Input: "
    Write-Host "Include pictures? y or n"
    $pictures = Read-Host "Input: "
    Write-Host "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

    foreach ($File in $DownloadsFiles) {
        Try{
            $FileExtension = [System.IO.Path]::GetExtension($File).Split('.')[1]

            if ($FileExtension -cmatch "exe" -or $FileExtension -cmatch "msi") {
                if ($programms -cmatch "y" -or $programms -cmatch "Y") {
                    Move-Item -Path $File.FullName -Destination $ProgrammsFolderPath
                    Write-Host "Succesfully moved $($File.FullName) to $ProgrammsFolderPath"
                    Write-Host "Sorted Programms`n"
                }
            }
            if ($FileExtension -cmatch "docx" -or $FileExtension -cmatch "doc" -or $FileExtension -cmatch "pdf") {
                if ($documents -cmatch "y" -or $documents -cmatch "Y") {
                    Move-Item -Path $File.FullName -Destination $DocumentsFolderPath
                    Write-Host "Succesfully moved $($File.FullName) to $DocumentsFolderPath "
                    Write-Host "Sorted Programms`n"
                }
            }
            if ($FileExtension -cmatch "apk" -or $FileExtension -cmatch "apks") {
                if ($apks -cmatch "y" -or $apks -cmatch "Y") {
                    Move-Item -Path $File.FullName -Destination $ApkFolderPath
                    Write-Host "Succesfully moved $($File.FullName) to $ApkFolderPath"
                    Write-Host "Sorted APKs`n"
                }
            }
            if ($FileExtension -cmatch "mp4" -or $FileExtension -cmatch "m4v" -or $FileExtension -cmatch "mkv") {
                if ($videos -cmatch "y" -or $videos -cmatch "Y") {
                    Move-Item -Path $File.FullName -Destination $VideosFolderPath
                    Write-Host "Succesfully moved $($File.FullName) to $VideosFolderPath"
                    Write-Host "Sorted Videos`n"
                }
            }
            if ($FileExtension -cmatch "mp3" -or $FileExtension -cmatch "wav" -or $FileExtension -cmatch "acc" -or $FileExtension -cmatch "mid" -or $FileExtension -cmatch "m4a"  ){
                if ($music -cmatch "y" -or $music -cmatch "Y") {
                    Move-Item -Path $File.FullName -Destination $MusicFolderpath
                    Write-Host "Succesfully moved $($File.FullName) to $MusicFolderPath"
                    Write-Host "Sorted Music`n"
                }
            }
            if ($FileExtension -cmatch "jpg" -or $FileExtension -cmatch "png" -or $FileExtension -cmatch "xcf"){
                if ($pictures -cmatch "y" -or $pictures -cmatch "Y") {
                    Move-Item -Path $File.FullName -Destination $PictureFolderPath
                    Write-Host "Succesfully moved $($File.FullName) to $PictureFolderPath"
                    Write-Host "Sorted Pictures`n"
                }
            }

        }
        Catch {
            Write-Host ""
            Write-Host $_.Exception.Message -ForegroundColor Red
            Write-Host $_.ScriptStackTrace
            Write-Host ""
        }
    }
    Write-Host "`nCompleted sorting the different file types in their own folder`n" -ForegroundColor Green
}

# ==================== GUI ==================== #

## visable Menu for user
Write-Host "1: Enter 1 to sort the Downloads Folder"
Write-Host "Q: Enter Q to quit."

$user_input = (Read-Host "Please decide: ").ToUpper()

switch ($user_input){
    '1' {sorter}
    'Q' {Write-Host "The script has been terminated" -BackgroundColor Red -ForegroundColor White}
    Default {Write-Host "Your selection = $user_input, is not valid. Please try again." -BackgroundColor Red -ForegroundColor White}
}
pause
