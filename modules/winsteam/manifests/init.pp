class winsteam {
	
	exec {'pwsh-format':
		command => '$(Get-Disk | Where partitionstyle -eq "raw" | Initialize-Disk -PartitionStyle MBR -PassThru | New-Partition -AssignDriveLetter -DriveLetter E -UseMaximumSize | Format-Volume -FileSystem NTFS -NewFileSystemLabel "Steam" -Confirm:$false),
		provider => powershell,
	}
	# Install and run steam to E:\Steam
    file {'C:\Puppetfiles\Steam.zip':
                source => 'puppet:///modules/winapps/Steam.zip',
                source_permissions => ignore,
				require => Exec['pwsh-format'],
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

}




