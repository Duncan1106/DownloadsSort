# Downloadsfolder
$DownloadsFolderPath = (New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path

# Programmsfolder
$ProgrammsFolderPath = [Environment]::GetFolderPath("MyDocuments") + "\Programms\"
$programmsoption = $args[0]

# Videofolder
$VideosFolderPath = [Environment]::GetFolderPath("MyVideos") + "\Downloaded\"
$videosoption = $args[1]

# Musicfolder
$MusicFolderpath = [Environment]::GetFolderPath("MyMusic") + "\Downloaded\"
$musicoption = $args[2]

# Picturefolder
$PictureFolderPath = [Environment]::GetFolderPath("MyPictures") + "\Downloaded\"
$pictureoption = $args[3]

# get all Files in Downloadsfolder
$DownloadsFiles = Get-ChildItem -Path $DownloadsFolderPath -File


foreach ($File in $DownloadsFiles) {
    $FileExtension = [System.IO.Path]::GetExtension($File).Split('.')[1]

    if ($FileExtension -cmatch "exe" -or $FileExtension -cmatch "msi") {
        if ($programmsoption -cmatch "y") {
           Move-Item -Path $File.FullName -Destination $ProgrammsFolderPath
           Write-Host "Succesfully moved $($File.FullName) to $ProgrammsFolderPath"
           Write-Host "Sorted Programms"
        }
    }

    if ($FileExtension -cmatch "mp4" -or $FileExtension -cmatch "m4v" -or $FileExtension -cmatch "mkv") {
        if ($videosoption -cmatch "y") {
            Move-Item -Path $File.FullName -Destination $VideosFolderPath
            Write-Host "Succesfully moved $($File.FullName) to $VideosFolderPath"
            Write-Host "Sorted Videos"
        }
    }

    if ($FileExtension -cmatch "mp3" -or $FileExtension -cmatch "wav" -or $FileExtension -cmatch "acc" -or $FileExtension -cmatch "mid" -or $FileExtension -cmatch "m4a"  ){
        if ($musicoption -cmatch "y") { 
            Move-Item -Path $File.FullName -Destination $MusicFolderpath
            Write-Host "Succesfully moved $($File.FullName) to $MusicFolderPath"
            Write-Host "Sorted Music"
        }
    }

    if ($FileExtension -cmatch "jpg" -or $FileExtension -cmatch "png" -or $FileExtension -cmatch "xcf"){
        if ($pictureoption -cmatch "y") { 
            Move-Item -Path $File.FullName -Destination $PictureFolderPath
            Write-Host "Succesfully moved $($File.FullName) to $PictureFolderPath"
            Write-Host "Sorted Pictures"
        }
    }
}
Write-Host "Completed sorting the different file types in their own folder"
Write-Host "--------------------------------------------------------------"
