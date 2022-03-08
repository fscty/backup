#!/bin/sh
echo "Removing original_backup/termux-backup.tar.gz.gpg..."
rm original_backup/termux-backup.tar.gz.gpg
echo "Combining all Split file into one backup file..."
cat splitfile/termux-backup.tar.gz.split* > original_backup/termux-backup.tar.gz.gpg
echo "Decrypting the backup into /original_backup folder.."
gpg -o original_backup/termux-backup.tar.gz -d original_backup/termux-backup.tar.gz.gpg
echo "Original backup ready here :\n $(ls -l original_backup)"
du -sh original_backup/termux-backup.tar.gz
