## Retrieves sensitive secrets from Keyvault in Azure
## Make sure you've run Connect-AzAccount before this script
$saname = Get-AzKeyVaultSecret -VaultName 'hdvkv' -Name 'resticsaname' -AsPlainText
$sakey = Get-AzKeyVaultSecret -VaultName 'hdvkv' -Name 'resticsakey' -AsPlainText
$bupw = Get-AzKeyVaultSecret -VaultName 'hdvkv' -Name 'resticbupw' -AsPlainText

$PWFILE='D:/PersonalWorkspace/homebackups/pw.txt'

if (Test-Path -Path $PWFILE -PathType Leaf) {
    Remove-Item $PWFILE
}

New-Item -Path $PWFILE -ItemType File
$bupw | Out-File $PWFILE

[Environment]::SetEnvironmentVariable("AZURE_ACCOUNT_NAME", $saname)
[Environment]::SetEnvironmentVariable("AZURE_ACCOUNT_KEY", $sakey)
$dirs=@("D:/PersonalWorkspace/homebackups")
$dirs | ForEach-Object {
    ./restic.exe -r azure:backups:/ --verbose backup $PSItem -p $PWFILE
}