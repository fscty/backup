#!/bin/sh
SIZE=$(du -sh original_backup/termux-backup.tar.gz)
DATE=$(stat original_backup/termux-backup.tar.gz |grep Modify | cut -c -24 | cut -c 8-)
echo "\033[1;31mAre you sure you want to restore termux? It will override everything data in your home folder \n \033[0m"
read -p "  (y/n)?" CONT
if [ "$CONT" = "y" ]; then
	echo "\033[1;34m Cloning fscty/backup.git \033[0m"
	rm -rf backup
	git clone https://github.com/fscty/backup.git
	cd backup
	echo "Removing old original_backup/termux-backup.tar.gz.gpg..."
	rm original_backup/termux-backup.tar.gz.gpg
	echo "Combining all Split file into one backup file..."
	cat splitfile/termux-backup.tar.gz.split* > original_backup/termux-backup.tar.gz.gpg
	echo "Decrypting the backup into /original_backup folder.."
	gpg -o original_backup/termux-backup.tar.gz -d original_backup/termux-backup.tar.gz.gpg
	echo "Original backup ready here :\n $(ls -l original_backup)"
	du -sh original_backup/termux-backup.tar.gz
	echo "Restoring Termux Environnement from /storage/emulated/0/utiles/termuxbackup/termux-backup.tar.gz\nSize of the backup: $SIZE\nLast Backup: \033[1;34m $DATE \033[0m......\n......\n.....\n...It takes a few minutes depending on size of your backup\n"
	tar -zxf original_backup/termux-backup.tar.gz -C /data/data/com.termux/files --recursive-unlink --preserve-permissions
	echo "\033[1;34mRESTORATION DONE\033[0m"
	apt-mark hold openssl postgresql openssl-1.1 openssl-1.1-static openssl-static openssl-tool openssl1.1-tool sslscan
	echo "\033[1;34mThe packages have been blocked from updates\033[0m";
else
	echo "exit";
fi
