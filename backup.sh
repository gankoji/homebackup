BINFILE=/c/Users/asaxp/Downloads/restic_0.12.0_windows_amd64/restic_0.12.0_windows_amd64.exe
PWFILE=/d/PersonalWorkspace/homebackups/pw.txt

#$BINFILE -r azure:backups:/ --verbose backup /d/PersonalWorkspace/homebackups -p /d/PersonalWorkspace/homebackups/pw.txt
dirs=("/d/PersonalWorkspace/homebackups")
for i in "${dirs[@]}"
do
    $BINFILE -r azure:backups:/ --verbose backup $i -p $PWFILE
done