class mysql {

$mysql_password = "myT0pS3cretPa55worD"
	
	package { "mysql-server": ensure => installed }


	service { "mysql":
		enable => true,
		ensure => running,
		require => Package["mysql-server"],
	}

	exec { "set-mysql-password":
		unless => "mysqladmin -uroot -p$mysql_password status",
		path => ["/bin", "/usr/bin"],
		command => "mysqladmin -uroot password $mysql_password",
		require => Service["mysql"],
	}

}
