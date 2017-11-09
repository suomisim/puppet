class vmslavesetup {
	
	package { 'puppet':
		ensure => 'installed',
	}
	file { '/etc/hosts':
		content => template('vmslavesetup/hosts.erb'),
	}
	file { '/etc/puppet/puppet.conf':
		content => template('vmslavesetup/puppet.conf.erb'),
		notify => Service['puppet'],
		require => Package['puppet'],
	}
	service { 'puppet':
		ensure  => 'true',
		enable  => true,
		require => Package['puppet'],
	}
	exec { 'puppet-agent-enable':
		path => ["/bin", "/usr/bin"],
		command => "puppet agent --enable",
		require => Service["puppet"],
	}
	exec { 'puppet-agent':
		path => ["/bin", "/usr/bin"],
		command => "puppet agent -tdv",
		require => Exec["puppet-agent-enable"],
	}
	
	
}




