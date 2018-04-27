If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`" $PSCommandArgs" -WorkingDirectory $pwd -Verb RunAs
	Exit
}

$volumes = Get-WmiObject -Class Win32_Volume | Select DeviceID

Foreach ($volume in $volumes) {
    $guid = $volume.DeviceID
    $guid = $guid.Substring(0,$guid.length-1)
    chkntfs.exe /x "$guid"
}

pause