class lamp {
	
	package { 'apache2':
		ensure => 'installed',
	}
#
#	file { '':
#		content => template(''),
#		notify => Service[''],
#		require => Package[''],
#
#	}
#    
	service { 'apache2':
		ensure  => 'true',
		enable  => true,
		require => Package['apache2'],
	}




	file { '/home/suomisim/public_html':
		ensure => 'directory',
	 
	}
	
	
	file { '/home/suomisim/public_html/index.html':
		content => template('lamp/index.html.erb'),
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




}
