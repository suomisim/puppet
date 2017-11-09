class vmmastersetup {
	
	package { 'puppetmaster':
		ensure => 'installed',
	}
	file { '/etc/hosts':
		content => template('vmmastersetup/hosts.erb'),
	}
	file { '/etc/puppet/manifests/site.pp':
		content => template('vmmastersetup/site.pp.erb'),
		require => Package['puppetmaster'],
	}
	file { '/etc/puppet/puppet.conf':
		content => template('vmmastersetup/puppet.conf.erb'),
		notify => Service['puppetmaster'],
		require => File['/etc/puppet/manifests/site.pp'],
	}
	exec { 'puppet-remcerts':
		path => ["/bin", "/usr/bin"],
		command => "rm -rf /var/lib/puppet/ssl/",
		require => File["/etc/puppet/puppet.conf"],
		notify => Service['puppetmaster'],
	} 
	service { 'puppetmaster':
		ensure  => 'true',
		enable  => true,
		require => Package['puppetmaster'],
	}

}




