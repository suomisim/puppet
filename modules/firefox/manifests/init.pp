
class firefox { 

	package { 'xul-ext-ublock-origin':
		ensure => 'installed',
		require => Package['firefox'],
	}

	
	package { 'firefox':
		ensure => 'installed',
	}

	file { '/etc/firefox/syspref.js':
		content => template('firefox/syspref.js.erb'),
		notify => Service['firefox'],
		require => Package['xul-ext-ublock-origin'],

	}
    
	service { 'firefox':
#		ensure  => 'true',
#		enable  => 'true',
		require => Package['firefox'],
		provider => 'systemd',
	}

}




