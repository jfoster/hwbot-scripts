If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`" $PSCommandArgs" -WorkingDirectory $pwd -Verb RunAs
	Exit
}

function IsNullOrWhiteSpace([string] $string) {
    if ($string -ne $null) {
        $string = $string.Trim()
    }
    return [string]::IsNullOrEmpty($string)
}

$volumes = Get-WmiObject -Class Win32_Volume
[array]::Reverse($volumes)

Foreach ($volume in $volumes) {
    #Write-Host $volume.DeviceID
    $drive = $volume.DriveLetter
    if (-Not (IsNullOrWhiteSpace($drive))) {
        #Write-Output $drive
        if (Test-Path $drive\Windows\System32\winload.efi) {
            bcdboot $drive\Windows /v
        }
    }
}
    
bcdedit /set "{default}" bootmenupolicy legacy

cmd /c Pause | Out-Null