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
    exec {'steam-extract':
            command => '7z.exe -y e C:\Puppetfiles\Steam.zip -oE:\Steam',
            path => 'C:\Program Files\7-Zip',
            require => File['C:\Puppetfiles\Steam.zip'],
    }
    exec {'steam-run':
            command => 'steam.exe -silent',
            path => 'E:\Steam',
			require => Exec['steam-extract'],
	}
	windows::shortcut { 'C:\Users\suomisim\Desktop\Steam.lnk':
		target      => 'E:\Steam\Steam.exe',
		description => 'Steam',
		require => Exec['steam-run'],
	}

}




