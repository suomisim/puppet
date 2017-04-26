class ufwmod {

  # Path to binaries, to shorten commands below and avoid global search path:
  $grep = '/bin/grep'
  $ufw = '/usr/sbin/ufw'
  $yes = '/usr/bin/yes'

	package { 'ufw':
		ensure => present,
	}

	Package['ufw'] -> Exec['ufw-default-deny'] -> Exec['ufw-enable']

	exec { 'ufw-default-deny':
		command => "${ufw} default deny",
		unless  => "${ufw} status verbose | ${grep} \"Default: deny (incoming), allow (outgoing)\"",
	}

	exec { 'ufw-enable':
		command => "${yes} | ${ufw} enable",
		unless  => "${ufw} status | ${grep} \"Status: active\"",
	}

	service { 'ufw':
		ensure    => running,
		enable    => true,
		hasstatus => true,
		subscribe => Package['ufw'],
	}
}
