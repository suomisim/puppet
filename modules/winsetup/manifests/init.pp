class winsetup {
	include chocolatey
	
	exec {'pwsh-remove':
		command => '$(Get-AppxPackage *zune* *3dbuilder* *windowsalarms* *windowscommunicationsapps* *windowscamera* *officehub* *skypeapp* *getstarted* *windowsmaps* 
		*solitairecollection* *bingfinance* *bingnews* *onenote* *people* *windowsphone* *photos* *bingsports* *soundrecorder* *bingweather* | Remove-AppxPackage)',
		provider => powershell,
	}
	file {'C:\Puppetfiles\uninstall_onedrive.bat':
		source => 'puppet:///modules/winsetup/uninstall_onedrive.bat',
		source_permissions => ignore,
	}
	exec {'onedrive-uninstall':
		command => "C:\Puppetfiles\uninstall_onedrive.bat",
		require => File["C:\Puppetfiles\uninstall_onedrive.bat"],
	}
	package {["firefox","7zip", "notepadplusplus", "ccleaner", "classic-shell", "discord"]:}
	Package {
       ensure => "installed",
       provider => "chocolatey",
	}
	registry_value{'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\TimeZoneInformation\RealTimeIsUniversal':
		ensure => present,
		type => dword,
		data => '1',
	}
	exec {'pwsh-format':
		command => '$(Get-Disk | Where partitionstyle -eq 'raw' | Initialize-Disk -PartitionStyle MBR -PassThru | New-Partition -AssignDriveLetter -DriveLetter E -UseMaximumSize | Format-Volume -FileSystem NTFS -NewFileSystemLabel "Steam" -Confirm:$false),
		provider => powershell,
	}
	file {'C:\Puppetfiles\SteamSetup.exe':
		source => 'puppet:///modules/winsetup/SteamSetup.exe',
		source_permissions => ignore,
		require => Exec["pwsh-format"],
	}
	package { "Steam":
		ensure    => installed,
		source    => 'C:\Puppetfiles\steam.exe',
		install_options => ['/VERYSILENT','INSTALLDIR=D:\Steam']
		require => File["C:\Puppetfiles\SteamSetup.exe"],
}


   
}

