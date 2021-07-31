BINFILE=/c/Users/asaxp/Downloads/restic_0.12.0_windows_amd64/restic_0.12.0_windows_amd64.exe
PWFILE=/d/PersonalWorkspace/homebackups/pw.txt
export AZURE_ACCOUNT_NAME=asaxpresticbu
export AZURE_ACCOUNT_KEY='1WFh7YXTHZtkSXPWqp2sphQFDnp66JHcFy4dBmd0ktf11TCMd0fkG9ll0cnI0ytVzbkkY4d/uL2WX+9ar0znXg=='

#$BINFILE -r azure:backups:/ --verbose backup /d/PersonalWorkspace/homebackups -p /d/PersonalWorkspace/homebackups/pw.txt
dirs=("/d/PersonalWorkspace/homebackups")
for i in "${dirs[@]}"
do
    $BINFILE -r azure:backups:/ --verbose backup $i -p $PWFILE
done