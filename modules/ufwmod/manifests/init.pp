class ufwmod {

	Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ] }

	package { 'ufw':
		ensure => 'installed',
		allowcdrom => 'true',
	}

	exec { 'ufw-enable':
		command => 'ufw enable',
		require => Package['ufw'],
	}
	file {'/etc/ufw/user.rules':
		content => template('ufwmod/user.rules.erb'),
		require => Package['ufw'],
		notify => Service['ufw'],
	}
	file {'/etc/ufw/user6.rules':
		content => template('ufwmod/user6.rules.erb'),
		require => Package['ufw'],
		notify => Service['ufw'],
	}
	service { 'ufw':
		ensure  => 'true',
		enable  => 'true',
		require => Package['ufw'],
	}
}
