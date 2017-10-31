class lamp {

# Apache palvelimen asennus
 	
	package { 'apache2':
		ensure => 'installed',
	}

# Apache palvelun käynnistys
   
	service { 'apache2':
		ensure  => 'true',
		enable  => 'true',
		require => Package['apache2'],
	}

# Käyttäjän  suomisim websivun kansion luonti

	file { '/home/suomisim/public_html':
		ensure => 'directory',
	}
	
# Käyttäjän suomisim kotisivun muokkaus

	file { '/home/suomisim/public_html/index.php':
		content => template('lamp/index.php.erb'),
		require => File['/home/suomisim/public_html'],
	}

# Käyttäjän websivukansion käyttöönotto (a2enmod userdir -komento)
	
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
	
# Apache-asennus päättyy tähän

	package {'libapache2-mod-php':
		ensure => 'installed',
	}
	
	file { '/etc/apache2/mods-available/php7.0.conf':
		content => template('lamp/php7.0.conf.erb'),
		require => Package["libapache2-mod-php"],
		notify => Service["apache2"],
	}
	
	package {'mysql-server':
		ensure => 'installed',
	}

	$mysqlpw = "guest"

	exec { 'set-mysql-password':
		path => ["/bin", "/usr/bin"],
		command => "mysqladmin -uroot password $mysqlpw",
		require => Package["mysql-server"],
	}
	
	service { 'mysql':
		ensure  => 'true',
		enable  => 'true',
		require => Package['mysql-server'],
	}
	
	package {'php-mysql':
		ensure => 'installed',
		require => Package['mysql-server'],
	}
		
}
