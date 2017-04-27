class slavesetup {
	
	package { 'puppet':
		ensure => 'installed',
	}

	file { '/etc/puppet/puppet.conf':
		content => template('slavesetup/puppet.conf.erb'),
		notify => Service['puppet'],
		require => Package['puppet'],

	}
    
	service { 'puppet':
		ensure  => 'true',
		enable  => true,
		require => Package['puppet'],
	}

	exec { 'puppet-agent':
		path => ["/bin", "/usr/bin"],
		command => "puppet agent -tdv",
		require => Service["puppet"],
	}
	
	
}




