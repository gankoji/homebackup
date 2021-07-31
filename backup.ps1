## Retrieves sensitive secrets from Keyvault in Azure
## Make sure you've run Connect-AzAccount before this script
$saname = Get-AzKeyVaultSecret -VaultName 'hdvkv' -Name 'resticsaname' -AsPlainText
$sakey = Get-AzKeyVaultSecret -VaultName 'hdvkv' -Name 'resticsakey' -AsPlainText
$bupw = Get-AzKeyVaultSecret -VaultName 'hdvkv' -Name 'resticbupw' -AsPlainText

## Temp file to write the repo password to
$PWFILE='D:/PersonalWorkspace/homebackups/pw.txt'

## If the temp file already exists, nuke it
if (Test-Path -Path $PWFILE -PathType Leaf) {
    Remove-Item $PWFILE
}

## Write the pw to the file
New-Item -Path $PWFILE -ItemType File
$bupw | Out-File $PWFILE

## Restic expects Azure SA Name and Key as env vars
[Environment]::SetEnvironmentVariable("AZURE_ACCOUNT_NAME", $saname)
[Environment]::SetEnvironmentVariable("AZURE_ACCOUNT_KEY", $sakey)

## Array of directories to backup to blob storage
$dirs=@("D:/PersonalWorkspace", "E:/RaidData", "E:/MiscData", "C:/Users/asaxp/Documents", "C:/Users/asaxp/Downloads")

## Iterate over above array, backing up each dir in turn. 
$dirs | ForEach-Object {
    ./restic.exe -r azure:backups:/ --verbose backup $PSItem -p $PWFILE
}