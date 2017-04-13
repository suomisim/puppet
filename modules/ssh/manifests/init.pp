class ssh { 

	package { 'ssh':
		ensure => 'installed',
	}

	file { '/etc/ssh/sshd_config':
		content => template('ssh/sshd_config.erb'),
		notify => Service['ssh'],
		require => Package['ssh'],

    }
    
	service { 'ssh':
		ensure  => 'true',
		enable  => true,
		provider => 'systemd',
		require => Package['ssh'],
	}

}
