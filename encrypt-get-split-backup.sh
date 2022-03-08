#!/bin/sh
SIZE=$(ls -lhF /storage/emulated/0/utiles/termuxbackup/termux-backup.tar.gz | cut -c 28-32)
DATE=$(stat /storage/emulated/0/utiles/termuxbackup/termux-backup.tar.gz |grep Modify | cut -c -24 | cut -c 8-)

BACKUPFILE=/storage/self/primary/utiles/termuxbackup/termux-backup.tar.gz
echo "Size of the last backup: \n\033[1;34m $SIZE\033[0m\nLast Backup: \033[1;34m $DATE \033[0m\n"
read -p " Are you sure you want to backup now and erase the old one?  (y/n)?" CONT
if [ "$CONT" = "y" ]; then
        echo "......"
        echo "...."
        echo ".."
        echo "."
        tar -zvcf $BACKUPFILE -C /data/data/com.termux/files ./home ./usr
        echo "\033[1;32m:::::::::::::::::\033[0m"
        echo "\033[1;32m:::BACKUP DONE:::\033[0m"
        echo "\033[1;32m:::::::::::::::::\033[0m";
        echo "\033[1;32m::::: $SIZE :::::\033[0m";
        echo "\033[1;32m:::::::::::::::::\033[0m";
        echo "\033[1;32m::::REFRESHING:::\033[0m";
        echo "\033[1;32m:::::::::::::::::\033[0m";
        echo "\033[1;32m:::::::::::::::::\033[0m";
        echo "\033[1;32m:::::SLEEP 30s:::\033[0m";
        echo "\033[1;32m:::::::::::::::::\033[0m";
        sleep 30
        echo "\033[1;32m:::::::::::::::::\033[0m";
        echo "\033[1;32m:::::::::::::::::\033[0m";
        echo "\033[1;32m::::: $SIZE :::::\033[0m";
        echo "\033[1;32m::::: $SIZE :::::\033[0m";
        echo "\033[1;32m::::: $SIZE :::::\033[0m";
        echo "\033[1;32m::::: $SIZE :::::\033[0m";
        echo "\033[1;32m::::: $SIZE :::::\033[0m";
        echo "\033[1;32m::::: $SIZE :::::\033[0m";
        echo "\033[1;32m::::: $SIZE :::::\033[0m";
        echo "\033[1;32m::::: $SIZE :::::\033[0m";
        echo "\033[1;32m::::: $SIZE :::::\033[0m";
        echo "\033[1;32m::::: $SIZE :::::\033[0m";
        echo "\033[1;32m::::: $SIZE :::::\033[0m";
        echo "\033[1;32m::::: $SIZE :::::\033[0m";
        echo "\033[1;32m::::: $SIZE :::::\033[0m";
        echo "\033[1;32m::::: $SIZE :::::\033[0m";
        echo "\033[1;32m::::: $SIZE :::::\033[0m";
        echo "\033[1;32m::::: $SIZE :::::\033[0m";
        echo "\033[1;32m::::: $SIZE :::::\033[0m";
        echo "\033[1;32m:::::::::::::::::\033[0m";
        echo "\033[1;32m:::::::::::::::::\033[0m";
        echo "\033[1;32m::::::DONE:::::::\033[0m";
        echo "\033[1;32m:::::::::::::::::\033[0m";
else
        echo "\033[1;33mNo backup was made\033[0m"
        echo "The last Backup at \033[1;34m $DATE \033[0m has not been touched"
        echo "Exit..";
fi
BACKFOLDER="backup$RANDOM"
echo "\033[1;33mDo you want to encrypt and gitpush \nyour backup on fscty/backup.git ? \033[0m"
read -p "  (y/n)?" CONT
if [ "$CONT" = "y" ]; then
	echo "Cloning the repo fscty/backup.git"
	git clone https://github.com/fscty/backup.git $BACKFOLDER
	cd $BACKFOLDER
	gpg --output original_backup/termux-backup.tar.gz.gpg --cipher-algo AES256 --symmetric $BACKUPFILE
	cp termux-backup.tar.gz.gpg original_backup/
	echo "Removing the Old Split files backup...\n"
	rm splitfile/termux-backup.tar.gz.split*
	echo "\033[1;32mTermux backup was encrypted and copy here..\033[0m"
	split --verbose -C 5M original_backup/termux-backup.tar.gz.gpg termux-backup.tar.gz.split.
	mv termux-backup.tar.gz.split.* splitfile
	echo "\033[1;32mAll split file has been moved in /splitfile/ folder\033[0m"
	rm original_backup/termux-backup.tar.gz.gpg
	echo "\033[1;33mOld backup has been removed..\033[0m"
	git add splitfile/*
	git commit -m "backup termux samsungA52 with all automatic script"
	cat ~/.note
	git push
	echo "\033[1;32mSplitFiles has been pushed\nAll backups are done.\033[0m"
else
	echo "\033[1;33mOkay, the backup wasn't save into the repo  fscty/backup.git\nExit.. \033[0m"
fi
