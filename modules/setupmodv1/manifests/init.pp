class setupmodv1 {
	
# Pakettien asennus
    
    $paketit = [ 'ssh', 'curl', 'lynx', 'shutter', 'geany', 'tree', 'firefox' ]

    package { $paketit: ensure => 'installed'    

    }

# Työpöydän asetukset	

	file {'/home/suomisim/.config/xfce4/panel/whiskermenu-1.rc':
		content => template('setupmodv1/whiskermenu-1.rc.erb'),
	}

	file { '/home/suomisim/.config/xfce4/terminal':
		ensure => 'directory',
	}

	file {'/home/suomisim/.config/xfce4/terminal/terminalrc':
		content => template('setupmodv1/terminalrc.erb'),
		require => File['/home/suomisim/.config/xfce4/terminal'],
	}

	file {'/home/suomisim/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml':
		content => template('setupmodv1/xfce4-panel.xml.erb'),
	}

	file {'/home/suomisim/.config/xfce4/panel/weather-11.rc':
		content => template('setupmodv1/weather-11.rc.erb'),
	}

# Firefox asetukset

	file { '/etc/firefox/syspref.js':
		content => template('setupmodv1/syspref.js.erb'),
	}

	package { 'xul-ext-ublock-origin':
		ensure => 'installed',
		require => File['/etc/firefox/syspref.js'],
	}

}
