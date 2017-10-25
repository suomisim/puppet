class ufwmod {
	
	# Komentojen polun määrittely
	Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ] }
	
	# Paketin asennus
	package { 'ufw':
		ensure => 'installed',
	}
	
	# Komennon ajo
	exec { 'ufw-enable':
		command => 'ufw enable',
		require => Package['ufw'],
	}
	# Asetustiedoston muokkaus (IPv4)
	file {'/etc/ufw/user.rules':
		content => template('ufwmod/user.rules.erb'),
		require => Package['ufw'],
		notify => Service['ufw'],
	}
	# Asetustiedoston muokkaus (IPv6)
	file {'/etc/ufw/user6.rules':
		content => template('ufwmod/user6.rules.erb'),
		require => Package['ufw'],
		notify => Service['ufw'],
	}
	# Servicen toiminnan varmistaminen
	service { 'ufw':
		ensure  => 'true',
		enable  => 'true',
		require => Package['ufw'],
	}
}
