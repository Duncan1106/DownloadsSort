
# Download Sorter

Sorts files from your downloads folder for you.


## Features

Sorts:
-   programms with extensions exe or msi
-   documents with extensions doc, docx or pdf
-   applications with extensions apk or apks
-   videos with extensionsmp4, m4v or mkv
-   audio with extensions mp3, wav, acc, mid or m4a
-   photos with extensions jpg, png or xcf

into prespecified but customisable folders

## Installation and Customisations
there are 2 ways of using this simple programm

-   ``` Easy ``` : you adapte to my predefinded folderstructure and go on and just use it
    -   for Programms and Apks you create a folder in your documents, one named 'Programms' and one named 'APKs' inside of the first folder
    -   for pictures you create a folder called 'Downloaded' in your Pictures folder created by WindowsStatsLogger
    -   for videos, the same as above, but in the video folder created by Windows
    -   for music the same as before
 
-   ``` Advanced ``` : you change following parts in my script

```bash
    - line 21: $ProgrammsFolderPath = [Environment]::GetFolderPath('MyDocuments') + '\Programms\' #for your Programms
```
```bash
    - line 24: $DocumentsFolderPath = [Environment]::GetFolderPath('MyDocuments') + '\Downloaded\' #for your documents
```
```bash
    - line 27: $ApkFolderPath = $ProgrammsFolderPath + '\APKs' #for your APKs
```
```bash
    - line 30: $VideosFolderPath = [Environment]::GetFolderPath('MyVideos') + '\Downloaded\' #for your Videos
```
```bash
    - line 33: $MusicFolderpath = [Environment]::GetFolderPath("MyMusic") + '\Downloaded\' #for your audio
```
```bash
    - line 36: $PictureFolderPath = [Environment]::GetFolderPath('MyPictures') + '\Downloaded\' #for your pictures
```


## Badges
![GitHub language count](https://img.shields.io/github/languages/count/Duncan1106/WindowsStatsLogger?color=lime&label=languages&logo=gray)
![GitHub Repo stars](https://img.shields.io/github/stars/Duncan1106/DownloadsSort?style=plastic)

## Security

[![PSScriptAnalyzer](https://github.com/Duncan1106/DownloadsSort/actions/workflows/powershell.yml/badge.svg)](https://github.com/Duncan1106/DownloadsSort/actions/workflows/powershell.yml)
[![Codacy Security Scan](https://github.com/Duncan1106/DownloadsSort/actions/workflows/codacy.yml/badge.svg)](https://github.com/Duncan1106/DownloadsSort/actions/workflows/codacy.yml)
