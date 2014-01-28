# Overview
This is a little ftp-sync script using LFTP.  
LFTP is a sophisticated ftp/http client, and a file transfer program supporting a number of network protocols. 

# Repository Files
* `.gitignore` - ignore rules to tell git what files to ignore
* `sync.sh` - sync script

# Installation

* clone/or fork the project
* install **[lftp](http://lftp.yar.ru/)** e.g. `brew install lftp` on a Mac or the likes
* create a file called **sync.cfg**. `touch sync.cfg`.
* add the following information `vim sync.cfg`

	ftp_host=your.ftp.com
	ftp_user=user123
	ftp_password=password123
	dir_local=/your/local/dir
	dir_remote=/your/remote/dir

* execute the shell script e.g. `./sync.sh`

# Fixes and next steps
* **Next step:** Generate a queue list
* **Next step:** Execute the script within tmux/screen
* **Next step:** Delete downloaded files e.g. 
	* https://serverfault.com/questions/24622/how-to-use-rsync-over-ftp
	* https://superuser.com/questions/508713/how-to-delete-empty-folders-on-ftp-server
	* http://www.sanitarium.co.za/delete-multiple-remote-files-and-directories-via-ftp/
	* https://stackoverflow.com/questions/16502034/download-and-delete-remote-files-using-lftp/16502552#16502552