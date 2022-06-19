# @Author: Duncan1106, Github
# Sorter with options to enable or disable different
# Extensions to sort in different folders

# ==================== SORTER ==================== #

Write-Host "================================================"
Write-Host "=============== Downloads Sorter ==============="
Write-Host "================================================"
Write-Host "=============== by Duncan1106 =================="
Write-Host "================================================"

Write-Debug "declared the different folders"
# Downloadsfolder
$DownloadsFolderPath = (New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path

# Programmsfolder
$ProgrammsFolderPath = [Environment]::GetFolderPath("MyDocuments") + "\Programms\"

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
    Write-Host "Include videos? y or n"
    $videos = Read-Host "Input: "
    Write-Host "Include music? y or n"
    $music = Read-Host "Input: "
    Write-Host "Include pictures? y or n"
    $pictures = Read-Host "Input: "

    foreach ($File in $DownloadsFiles) {
        $FileExtension = [System.IO.Path]::GetExtension($File).Split('.')[1]

        if ($FileExtension -cmatch "exe" -or $FileExtension -cmatch "msi") {
            if ($programms -cmatch "y") {
               Move-Item -Path $File.FullName -Destination $ProgrammsFolderPath
               Write-Host "Succesfully moved $($File.FullName) to $ProgrammsFolderPath"
               Write-Host "Sorted Programms"
            }
        }

        if ($FileExtension -cmatch "mp4" -or $FileExtension -cmatch "m4v" -or $FileExtension -cmatch "mkv") {
            if ($videos -cmatch "y") {
                Move-Item -Path $File.FullName -Destination $VideosFolderPath
                Write-Host "Succesfully moved $($File.FullName) to $VideosFolderPath"
                Write-Host "Sorted Videos"
            }
        }

        if ($FileExtension -cmatch "mp3" -or $FileExtension -cmatch "wav" -or $FileExtension -cmatch "acc" -or $FileExtension -cmatch "mid" -or $FileExtension -cmatch "m4a"  ){
            if ($music -cmatch "y") { 
                Move-Item -Path $File.FullName -Destination $MusicFolderpath
                Write-Host "Succesfully moved $($File.FullName) to $MusicFolderPath"
                Write-Host "Sorted Music"
            }
        }

        if ($FileExtension -cmatch "jpg" -or $FileExtension -cmatch "png" -or $FileExtension -cmatch "xcf"){
            if ($pictures -cmatch "y") { 
                Move-Item -Path $File.FullName -Destination $PictureFolderPath
                Write-Host "Succesfully moved $($File.FullName) to $PictureFolderPath"
                Write-Host "Sorted Pictures"
            }
        }
    }
    Write-Host "Completed sorting the different file types in their own folder"
}

# ==================== GUI ==================== #

## visable Menu for user
Write-Host "1: Enter 1 to sort the Downloads Folder"
Write-Host "Q: Enter Q to quit."

$input = (Read-Host "Please decide: ").ToUpper()

switch ($input){
    '1' {sorter}
    'Q' {Write-Host "The script has been terminated" -BackgroundColor Red -ForegroundColor White}
    Default {Write-Host "Your selection = $input, is not valid. Please try again." -BackgroundColor Red -ForegroundColor White}
}
pause
