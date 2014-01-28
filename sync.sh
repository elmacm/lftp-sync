#!/bin/bash

# Credentials
## inspired by: http://www.torrent-invites.com/showthread.php?t=132965&s=a5f6146c4e37fbcce4529ecd93c1989e
## inspired by: http://sourceserver.info/wiki/tutorial/root/abgleich_ftp
## lftp manpage: http://lftp.yar.ru/lftp-man.html

# Check if sync.cfg can be found and no parameters are missing
if [ ! sync.cfg ]; then echo "sync.cfg could not be found."; exit; fi
source sync.cfg
if [ -z "$ftp_host" ]; then echo "FTP-Host is missing in sync.cfg."; exit; fi
if [ -z "$ftp_user" ]; then echo "FTP-User is missing in sync.cfg."; exit; fi
if [ -z "$ftp_password" ]; then echo "FTP-Password is missing in sync.cfg."; exit; fi
if [ -z "$dir_local" ]; then echo "Local directory is missing in sync.cfg."; exit; fi
if [ -z "$dir_remote" ]; then echo "Remote directory is missing in sync.cfg."; exit; fi

echo -e "Start mirroring\n"
echo "Host: $ftp_host"
echo "User: $ftp_user"
echo "Password: ****"
echo
echo "Local directory: $dir_local"
echo "Remote directory: $dir_remote"
echo

trap "rm -f sync.lock" SIGINT SIGTERM

if [ -e sync.lock ]
then
  echo "Sync is already running."
  exit 1
else
  touch sync.lock
  lftp -u $ftp_user,$ftp_password $ftp_host << EOF
  ## Some ftp servers hide dot-files by default (e.g. .htaccess), and show them only when LIST command is used with -a option.
  set ftp:list-options -a
  ## if  true, try to negotiate SSL connection with ftp server for non-anonymous access. Default is true. This and other ssl settings are only available if lftp was compiled with an ssl/tls library.
  set ftp:ssl-allow yes
  ## specifies -n option for pget command used to transfer every single file under mirror. Default is 1 which disables pget.
  set mirror:use-pget-n 5

  ## --only-missing # download only missing files
  ## --continue # continue a mirror job if possible
  ## -P5 # download N files in parallel
  ## --log=sync.log # write lftp commands being executed to FILE

  mirror\
    --only-missing\
    --continue\
    -P5\
    --log=sync.log\
    $dir_remote\
    $dir_local
  quit
EOF
  ## delete sync.lock
  rm -f sync.lock
  exit 0
fi