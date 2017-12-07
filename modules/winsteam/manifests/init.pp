class winsteam {
	
	package { '':
		ensure => 'installed',
	}

	file { '':
		content => template(''),
		notify => Service[''],
		require => Package[''],

	}
    
	service { '':
		ensure  => 'true',
		enable  => true,
		require => Package[''],
	}

}




