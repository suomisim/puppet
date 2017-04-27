class mastersetup {
	
	package { 'puppetmaster':
		ensure => 'installed',
	}

	file { '/etc/puppet/puppet.conf':
		content => template('mastersetup/puppet.conf.erb'),
		notify => Service['puppetmaster'],
		require => Package['puppetmaster'],

	}
    
	service { 'puppetmaster':
		ensure  => 'true',
		enable  => true,
		require => Package['puppetmaster'],
	}

}




