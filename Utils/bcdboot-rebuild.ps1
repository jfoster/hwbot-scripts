If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`" $PSCommandArgs" -WorkingDirectory $pwd -Verb RunAs
	Exit
}

$volumes = Get-WmiObject -Class Win32_Volume
[array]::Reverse($volumes)

Foreach ($volume in $volumes) {
    $drive = $volume.DriveLetter
    if (Test-Path $drive\Windows) {
        bcdboot $drive\Windows /l en-gb
    }
}

bcdedit /set "{default}" bootmenupolicy legacy
bcdedit

cmd /c Pause | Out-Null