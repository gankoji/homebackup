## Retrieves sensitive secrets from Keyvault in Azure
## Make sure you've run Connect-AzAccount before this script
$saname = Get-AzKeyVaultSecret -VaultName 'hdvkv' -Name 'resticsaname' -AsPlainText
$sakey = Get-AzKeyVaultSecret -VaultName 'hdvkv' -Name 'resticsakey' -AsPlainText
$bupw = Get-AzKeyVaultSecret -VaultName 'hdvkv' -Name 'resticbupw' -AsPlainText

$PWFILE='/Users/jbailey/PersonalWorkspace/homebackup/pw.txt'
$RESTIC='/opt/homebrew/bin/restic'

if (Test-Path -Path $PWFILE -PathType Leaf) {
    Remove-Item $PWFILE
}

New-Item -Path $PWFILE -ItemType File
$bupw | Out-File $PWFILE

[Environment]::SetEnvironmentVariable("AZURE_ACCOUNT_NAME", $saname)
[Environment]::SetEnvironmentVariable("AZURE_ACCOUNT_KEY", $sakey)

$dirs=@("/Users/jbailey/PersonalWorkspace", "/Users/jbailey/Documents")

$dirs | ForEach-Object {
    $argstr = ' -r azure:backups:/ --verbose restore latest --target $PSItem --path $PSItem -p $PWFILE'
    $cmdstr = $RESTIC + $argstr
    Invoke-Expression $cmdstr
}