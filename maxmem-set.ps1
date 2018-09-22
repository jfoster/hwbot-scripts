If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`" $PSCommandArgs" -WorkingDirectory $pwd -Verb RunAs
	Exit
}

$mem = ((Read-host -Prompt "Maximum Memory in MB: ")/1)*1024*1024
if ($mem -eq 0) {
	bcdedit /deletevalue truncatememory
} else {
	bcdedit /set truncatememory $mem
}
