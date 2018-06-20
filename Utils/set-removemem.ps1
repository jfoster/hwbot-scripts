If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`" $PSCommandArgs" -WorkingDirectory $pwd -Verb RunAs
	Exit
}

$meminstalled = [int](Get-WmiObject Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum | Foreach {"{0:N2}" -f ([math]::round(($_.Sum / 1MB),2))})
$choice = ((Read-host -Prompt "Max Memory in MB: ")/1)
$sum = $meminstalled - $choice
if ($choice -eq 0) {
	bcdedit /deletevalue removememory
} else {
	bcdedit /set removememory $sum
}
cmd.exe /c pause>nul