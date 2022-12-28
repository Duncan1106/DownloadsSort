# Import the System.Windows.Forms namespace
Add-Type -AssemblyName System.Windows.Forms

# Create a form
$form = New-Object System.Windows.Forms.Form
$form.Text = "File Sorter"
$form.Width = 500
$form.Height = 500

# Create a list box to display the file extensions
$listBox = New-Object System.Windows.Forms.ListBox
$listBox.Width = 200
$listBox.Height = 400
$listBox.Location = New-Object System.Drawing.Point(10, 10)

# Add the list box to the form
$form.Controls.Add($listBox)

# Get the path to the download folder
$DownloadsFolderPath = (New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path

# Get all file extensions in the download folder
$fileExtensions = Get-ChildItem -LiteralPath $DownloadsFolderPath -Attributes !Directory | Select-Object Extension | Sort-Object Extension -Unique

# Add the file extensions to the list box
foreach ($fileExtension in $fileExtensions) {
  $listBox.Items.Add($fileExtension.Extension)
}

# Declare a variable to store the target folder
$global:targetFolder = ""

# Create a button to select the target folder
$selectFolderButton = New-Object System.Windows.Forms.Button
$selectFolderButton.Text = "Select Folder"
$selectFolderButton.Width = 100
$selectFolderButton.Height = 30
$selectFolderButton.Location = New-Object System.Drawing.Point(300, 10)

# Create a folder browser dialog
$folderBrowserDialog = New-Object System.Windows.Forms.FolderBrowserDialog

# Add a click event handler for the select folder button
$selectFolderButton.Add_Click({
  # Show the folder browser dialog
  $result = $folderBrowserDialog.ShowDialog()

  # Check if the user selected a folder
  if ($result -eq "OK") {
    # Set the selected folder as the target folder
    $global:targetFolder = $folderBrowserDialog.SelectedPath
    write-host "$global:targetFolder"
  }
})

# Add the select folder button to the form
$form.Controls.Add($selectFolderButton)

# Create a button to sort the files
$sortButton = New-Object System.Windows.Forms.Button
$sortButton.Text = "Sort Files"
$sortButton.Width = 100
$sortButton.Height = 30
$sortButton.Location = New-Object System.Drawing.Point(300, 50)

# Add a click event handler for the sort button
$sortButton.Add_Click({
  # Get the selected file extension from the list box
  $selectedExtension = $listBox.SelectedItem

  # Check if a file extension is selected
  if ($selectedExtension) {
    # Check if the user entered a target folder
    if ($global:targetFolder) {
      # Get all files with the selected file extension in the download folder
      $files = Get-ChildItem -LiteralPath $DownloadsFolderPath -Attributes !Directory -Filter "*$selectedExtension"

			# Loop through each file
      foreach ($file in $files) {
        # Output the file name and target folder
				$targetFile = "$DownloadsFolderPath/$file"
        Write-Host "Moving file $targetFile to folder $global:targetFolder"

        # Move the file to the target folder
        try {
          # Move the file to the target folder
          Move-Item -Path $targetFile -Destination $global:targetFolder
        } catch {
          # If the file already exists in the target folder, output a message and skip the file
          Write-Output "Skipping file $file because it already exists in the target folder"
        }
      }
    } else {
      # Skip the files with the selected file extension
      Write-Output "Skipping files with extension $selectedExtension"
    }
  } else {
  # Output a message indicating that no file extension was selected
  Write-Output "Please select a file extension from the list."
	}
})

# Add the sort button to the form
$form.Controls.Add($sortButton)

# Show the form
$form.ShowDialog()