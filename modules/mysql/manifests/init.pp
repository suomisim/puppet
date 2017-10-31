class mysql {

	package { "mysql-server": ensure => installed }

	
	service { "mysql":
		enable => true,
		ensure => running,
		require => Package["mysql-server"],
	}
	$mysql_password = "guest"
	exec { "mysql-change-pw":
		unless => "mysqladmin -uroot -p$mysql_password status",
		path => ["/bin", "/usr/bin"],
		command => "mysqladmin -uroot password $mysql_password",
		require => Service["mysql"],
	}
	$mysql_command = "mysql -uroot -pguest --execute='CREATE DATABASE wordpress DEFAULT CHARACTER SET UTF8; GRANT ALL ON wordpress.* TO wordpressuser@localhost IDENTIFIED BY wpuser;'"
	exec { "create-mysql-db":
		path => ["/bin", "/usr/bin"],
		command => $mysql_command,
		require => Exec["mysql-change-pw"],
	}
#	exec { "mysql-grant-db":
#		path => ["/bin", "/usr/bin"],
#		command => 'mysql -uroot -pguest --execute="GRANT ALL ON wordpress.* TO wordpressuser@localhost IDENTIFIED BY wpuser;"',
#		require => Exec["create-mysql-db"],
#	}


}
