class lamp {
	
	package { 'apache2':
		ensure => 'installed',
	}
   
	service { 'apache2':
		ensure  => 'true',
		enable  => true,
		require => Package['apache2'],
	}


	file { '/home/suomisim/public_html':
		ensure => 'directory',
	 
	}
	
	
	file { '/home/suomisim/public_html/index.php':
		content => template('lamp/index.php.erb'),
		require => File['/home/suomisim/public_html'],
	
	
	}
	
	file { '/etc/apache2/mods-enabled/userdir.load':
		ensure => 'link',
		target => '/etc/apache2/mods-available/userdir.load',
		notify => Service["apache2"],
		require => Package["apache2"],
	}

	file { '/etc/apache2/mods-enabled/userdir.conf':
		ensure => 'link',
		target => '/etc/apache2/mods-available/userdir.conf',
		notify => Service["apache2"],
		require => Package["apache2"],
        
        }


	package {'libapache2-mod-php':
		ensure => installed
	}
	
	file { '/etc/apache2/mods-available/php7.0.conf':
		content => template('lamp/php7.0.conf.erb'),
		require => Package["libapache2-mod-php"],
		notify => Service["apache2"],
	}

}
