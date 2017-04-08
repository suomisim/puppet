class packetmod {



	exec { 'apt-update':                  
		command => '/usr/bin/apt-get update'  
    }

    $paketit = [ 'geany', 'shutter', 'tree', 'puppet', 'git' ]

    package { $paketit: ensure => 'latest'

    }

}
