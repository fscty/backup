### Automatic scripts:
## Backup / Encrypt / Gitpush 
```bash
source <(curl -s https://raw.githubusercontent.com/fscty/backup/main/encrypt-get-split-backup.sh)
```
## Restore / Decrypt / Gitclone
```bash
source <(curl -s https://raw.githubusercontent.com/fscty/backup/main/restore-alltermux-environnement.sh)
```
## Decrypt / Only Get backup file
```bash
source <(curl -s https://raw.githubusercontent.com/fscty/backup/main/decrypt-unsplit-backup.sh)
```

# To restore your termux environnement in full:

restore-alltermux-environnement.sh

# To backup and encrypt all your termux environnement:

encrypt-get-split-backup.sh

# To decrypt and only get the backup file 

decrypt-unsplit-backup.sh
