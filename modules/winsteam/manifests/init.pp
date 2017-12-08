class winsteam {
	include chocolatey
	
	package {'7zip':
		ensure => "installed",
		provider => "chocolatey",
	}

	user {'suomisim':
		name      => 'suomisim',
		ensure    => present,
		groups    => ['Users'],
		password  => 'vaihdettava',
		managehome => true,
		require => Package['7zip'],
	}
	
    exec {'pwsh-format-one':
            command => '$(Get-Disk 1 | Initialize-Disk -PartitionStyle MBR -PassThru)',
            provider => powershell,
			require => User['suomisim'],
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
            source => 'puppet:///modules/winapps/Steam.zip',
            source_permissions => ignore,
			require => File['C:\Puppetfiles'],
	}
    file {'C:\Puppetfiles\extract-steam.bat':
            source => 'puppet:///modules/winapps/extract-steam.bat',
            source_permissions => ignore,
            require => File['C:\Puppetfiles\Steam.zip'],
    }
    exec {'extract-steam':
            command => 'extract-steam.bat',
            path => 'C:\Puppetfiles',
			require => File["C:\Puppetfiles\extract-steam.bat"],
	}
	windows::shortcut { 'C:\Users\suomisim\Desktop\Steam.lnk':
		target      => 'E:\Steam\Steam.exe',
		description => 'Steam',
		require => Exec['extract-steam'],
	}

}




