class liveusbsetup {

# Komentojen polun määrittely
	
	Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ] }
	
# Pakettien asennus

    $paketit = [ 'ssh', 'curl', 'lynx', 'shutter', 'geany', 'tree', 'firefox', 'vagrant', 'virtualbox' ]

    package { $paketit: 
		ensure => 'installed',
		allowcdrom => 'true',
    }

# Työpöydän asetukset	

	file {'/home/suomisim/.config/xfce4/panel/whiskermenu-1.rc':
		content => template('liveusbsetup/whiskermenu-1.rc.erb'),
	}

	file { '/home/suomisim/.config/xfce4/terminal':
		ensure => 'directory',
	}

	file {'/home/suomisim/.config/xfce4/terminal/terminalrc':
		content => template('liveusbsetup/terminalrc.erb'),
		require => File['/home/suomisim/.config/xfce4/terminal'],
	}

	file {'/home/suomisim/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml':
		content => template('liveusbsetup/xfce4-panel.xml.erb'),
	}

	file {'/home/suomisim/.config/xfce4/panel/weather-11.rc':
		content => template('liveusbsetup/weather-11.rc.erb'),
	}

# Firefox asetukset

	file { '/etc/firefox/syspref.js':
		content => template('liveusbsetup/syspref.js.erb'),
	}

	package { 'xul-ext-ublock-origin':
		ensure => 'installed',
		require => File['/etc/firefox/syspref.js'],
		allowcdrom => 'true',
	}
# Hostnamen muutos

	exec { 'hostnamectl':
		command => 'hostnamectl set-hostname itlabra',
		unless => 'hostname | grep itlabra',
		require => Package['xul-ext-ublock-origin'],
	}
	file { '/etc/hosts':
		content => template('liveusbsetup/hosts.erb'),
		require => Exec['hostnamectl'],
	}

}
