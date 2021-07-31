# Homebackup
This project is a very simplistic set of Powershell (and possibly zsh and bash
in the future) scripts for interfacing with the excellent [Restic
utility](https://restic.readthedocs.io/en/latest/010_introduction.html). Restic
does all the hard work here, we're just using it and the Azure CLI here to
handle the backend work and make it seamless for me to backup to and restore
from Azure Blob Storage. Note that these scripts access sensitive secrets
information directly from a keyvault in Azure: if you plan to use these bits,
you'll need to setup your own secrets in your own keyvault. 

## Requirements
- Powershell 5.1 or greater
- Azure CLI (*not* the az cli)
- Restic v0.12.0
