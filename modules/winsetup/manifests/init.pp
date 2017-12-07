class winsetup {
	include chocolatey
	
	# Windows Update - Ask to download & ask to install
	registry_key{'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate':
		ensure => present,
    }
    registry_value{'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU':
        ensure => present,
        type => dword,
        data => '2',
        require => Registry_key['HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate'],
    }
	file {'C:\Puppetfiles': ensure => directory,}
	# Format a raw drive to E: and name it "Steam" tässä oli ongelma korjattu jotain
#	exec {'pwsh-format':
#		command => '$(Get-Disk | Where partitionstyle -eq "raw" | Initialize-Disk -PartitionStyle MBR -PassThru | New-Partition -AssignDriveLetter -DriveLetter E -UseMaximumSize | Format-Volume -FileSystem NTFS -NewFileSystemLabel "Steam" -Confirm:$false),
#		provider => powershell,
#		require => File['C:\Puppetfiles'],
#	}
#	# Install and run steam to E:\Steam
#    file {'C:\Puppetfiles\Steam.zip':
#                source => 'puppet:///modules/winapps/Steam.zip',
#                source_permissions => ignore,
#				require => Exec['pwsh-format'],
#   }
#    file {'C:\Puppetfiles\extract-steam.bat':
#                source => 'puppet:///modules/winapps/extract-steam.bat',
#                source_permissions => ignore,
#                require => File['C:\Puppetfiles\Steam.zip'],
#    }
#    exec {'extract-steam':
#                command => 'extract-steam.bat',
#                require => File["C:\Puppetfiles\extract-steam.bat"],
#                path => 'C:\Puppetfiles',
#    }
	# Create user
	user {'suomisim':
		name      => 'suomisim',
		ensure    => present,
		groups    => ['Users'],
		password  => 'vaihdettava',
		managehome => true,
	}
	# Remove all modern Windows Apps (except Store)
	exec {'pwsh-remove':
		command => '$(Get-AppxPackage | where-object {$_.name –notlike "*store*"} --allusers | Remove-AppxPackage)',
		provider => powershell,
	}
	# Uninstall onedrive
	file {'C:\Puppetfiles\uninstall_onedrive.bat':
		source => 'puppet:///modules/winsetup/uninstall_onedrive.bat',
		source_permissions => ignore,
		require => File['C:\Puppetfiles'],
	}
	exec {'onedrive-uninstall':
		command => "C:\Puppetfiles\uninstall_onedrive.bat",
		require => File["C:\Puppetfiles\uninstall_onedrive.bat"],
	}
	# Install apps discord ei toimi molemmilla käyttäjillä, vaihdetaan .install
	package {["firefox","7zip", "notepadplusplus", "ccleaner", "classic-shell", "discord.install"]:}
	Package {
       ensure => "installed",
       provider => "chocolatey",
	}
	# Correct time in case of Ubuntu boot or install
	registry_value{'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\TimeZoneInformation\RealTimeIsUniversal':
		ensure => present,
		type => dword,
		data => '1',
	}
#	windows::shortcut { 'C:\Users\suomisim\Desktop\Steam.lnk':
#		target      => 'E:\Steam\Steam.exe',
#		description => 'Steam',
#	}
	class { 'windows::power_scheme':
		ensure => 'High performance',
	}
	file {'C:\Puppetfiles\Win10.ps1':
		source => 'puppet:///modules/winapps/Win10.ps1',
        source_permissions => ignore,
		require => 
    }
    exec {'pwsh-clean':
        command => '$(C:\Puppetfiles\Win10.ps1)',
        provider => powershell,
        require => File['C:\Puppetfiles\Win10.ps1'],
    }



	
	
	

	
	
}

