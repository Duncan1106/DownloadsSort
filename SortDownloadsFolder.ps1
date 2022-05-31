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

foreach ($File in $DownloadsFiles) {
    $FileExtension = [System.IO.Path]::GetExtension($File).Split('.')[1]

     if ($FileExtension -cmatch "exe" -or $FileExtension -cmatch "msi" ) {
        Move-Item -Path $File.FullName -Destination $ProgrammsFolderPath
        Write-Output "Succesfully moved $($File.FullName) to $ProgrammsFolderPath"
     }

     elseif ($FileExtension -cmatch "mp4" -or $FileExtension -cmatch "m4v" -or $FileExtension -cmatch "mkv") {
        Move-Item -Path $File.FullName -Destination $VideosFolderPath
        Write-Output "Succesfully moved $($File.FullName) to $VideosFolderPath"
     }

     elseif ($FileExtension -cmatch "mp3" -or $FileExtension -cmatch "wav" -or $FileExtension -cmatch "acc" -or $FileExtension -cmatch "mid" -or $FileExtension -cmatch "m4a"  ){
        Move-Item -Path $File.FullName -Destination $MusicFolderpath
        Write-Output "Succesfully moved $($File.FullName) to $MusicFolderPath"
     }

     elseif ($FileExtension -cmatch "jpg" -or $FileExtension -cmatch "png" -or $FileExtension -cmatch "xcf"){
        Move-Item -Path $File.FullName -Destination $PictureFolderPath
        Write-Output "Succesfully moved $($File.FullName) to $PictureFolderPath"
     }
}
Write-Output "Completed sorting the different file types in their own folder"
Write-Output "--------------------------------------------------------------"
pause
