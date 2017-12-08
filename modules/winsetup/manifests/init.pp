class winsetup {
	include chocolatey
	
	class {'windows::power_scheme':
		ensure => 'High performance',
	}
	
	registry_key{'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate':
		ensure => present,
		require => Class['windows::power_scheme'],
    }
		
    registry_value{'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU':
        ensure => present,
        type => dword,
        data => '2',
        require => Registry_key['HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate'],
    }
	registry_value{'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\TimeZoneInformation\RealTimeIsUniversal':
		ensure => present,
		type => dword,
		data => '1',
		require => Registry_value['HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU'],
	}
	
	exec {'pwsh-remove':
		command => '$(Get-AppxPackage -allusers | Remove-AppxPackage)',
		provider => powershell,
		require => Registry_value['HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\TimeZoneInformation\RealTimeIsUniversal'],
	}

	file {'C:\Puppetfiles\uninstall_onedrive.bat':
		source => 'puppet:///modules/winsetup/uninstall_onedrive.bat',
		source_permissions => ignore,
		require => Exec['pwsh-remove'],
	}
	exec {'onedrive-uninstall':
		command => "C:\Puppetfiles\uninstall_onedrive.bat",
		require => File["C:\Puppetfiles\uninstall_onedrive.bat"],
	}

	package {["firefox", "notepadplusplus", "ccleaner", "classic-shell", "discord.install"]:}
	Package {
       ensure => "installed",
       provider => "chocolatey",
	   require => Exec['onedrive-uninstall'],
	}

	file {'C:\Puppetfiles\Win10.ps1':
		source => 'puppet:///modules/winapps/Win10.ps1',
        source_permissions => ignore,
		require => Package['"firefox", "notepadplusplus", "ccleaner", "classic-shell", "discord.install"'],
    }
    exec {'pwsh-clean':
        command => '$(C:\Puppetfiles\Win10.ps1)',
        provider => powershell,
        require => File['C:\Puppetfiles\Win10.ps1'],
    }



	
	
	

	
	
}

