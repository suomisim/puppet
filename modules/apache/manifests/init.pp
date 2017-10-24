class apache {
	
# Apache palvelimen asennus
 	
	package { 'apache2':
		ensure => 'installed',
		allowcdrom => "true",
	}

# Apache palvelun käynnistys
   
	service { 'apache2':
		ensure  => 'true',
		enable  => 'true',
		require => Package['apache2'],
		
	}
	
}




