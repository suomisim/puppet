class winsteam {
	include chocolatey
	
	package {'7zip':
		ensure => "installed",
		provider => "chocolatey",
	}
    exec {'pwsh-format-one':
            command => '$(Get-Disk 1 | Initialize-Disk -PartitionStyle MBR -PassThru)',
            provider => powershell,
			require => Package['7zip'],
    }
    exec {'pwsh-format-two':
            command => '$(Get-Disk 1 | New-Partition -AssignDriveLetter -UseMaximumSize | Format-Volume -FileSystem NTFS -NewFileSystemLabel "Steam" -Confirm:$false)',
            provider => powershell,
            require => Exec['pwsh-format-one'],
    }
	file {'C:\Puppetfiles': 
			ensure => directory,
			require => Exec['pwsh-format-two'],
	}	
    file {'C:\Puppetfiles\Steam.zip':
            source => 'puppet:///modules/winsteam/Steam.zip',
            source_permissions => ignore,
			require => File['C:\Puppetfiles'],
	}
    exec {'steam-extract':
            command => '7z.exe -y e C:\Puppetfiles\Steam.zip -oE:\Steam',
            path => 'C:\Program Files\7-Zip',
            require => File['C:\Puppetfiles\Steam.zip'],
	}
	windows::shortcut { 'C:\Users\Administrator\Desktop\Steam.lnk':
			target      => 'E:\Steam\Steam.exe',
			description => 'Steam',
			require => Exec['steam-extract'],
	}
	file {'C:\Puppetfiles\runsteam.bat':
            source => 'puppet:///modules/winsteam/runsteam.bat',
            source_permissions => ignore,
			require => Windows::shortcut ['C:\Users\suomisim\Desktop\Steam.lnk'],
	}
    exec {'steam-run':
            command => 'runsteam.bat',
            path => 'C:\Puppetfiles',
			require => File['C:\Puppetfiles\runsteam.bat'],
	}

}




