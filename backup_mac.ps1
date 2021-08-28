## Retrieves sensitive secrets from Keyvault in Azure
## Make sure you've run Connect-AzAccount before this script
$saname = Get-AzKeyVaultSecret -VaultName 'hdvkv' -Name 'resticsaname' -AsPlainText
$sakey = Get-AzKeyVaultSecret -VaultName 'hdvkv' -Name 'resticsakey' -AsPlainText
$bupw = Get-AzKeyVaultSecret -VaultName 'hdvkv' -Name 'resticbupw' -AsPlainText

## Temp file to write the repo password to
$PWFILE='/Users/jbailey/PersonalWorkspace/homebackup/pw.txt'
$RESTIC='/opt/homebrew/bin/restic'

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
$dirs=@("/Users/jbailey/PersonalWorkspace", "/Users/jbailey/Documents")

## Iterate over above array, backing up each dir in turn. 
$dirs | ForEach-Object {
    $argstr = ' -r azure:backups:/ --verbose backup $PSItem -p $PWFILE'
    $cmdstr = $RESTIC + $argstr
    Invoke-Expression $cmdstr
}