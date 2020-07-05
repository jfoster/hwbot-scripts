$mem = ((Read-host -Prompt "Maximum Memory in MB: ")/1)*1024*1024
if ($mem -eq 0) {
	bcdedit /deletevalue truncatememory
} else {
	bcdedit /set truncatememory $mem
}
