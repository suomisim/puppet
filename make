#!/bin/bash

# A script to create a module and needed folders

echo -n "Module name: "

read HANDLE

cd modules

mkdir $HANDLE

mkdir $HANDLE/manifests/
mkdir $HANDLE/templates/

touch $HANDLE/manifests/init.pp
touch $HANDLE/readme.md

cat <<EOT >> $HANDLE/manifests/init.pp
class $HANDLE {
	
	package { '':
		ensure => 'installed',
	}

	file { '':
		content => template(''),
		notify => Service[''],
		require => Package[''],

	}
    
	service { '':
		ensure  => 'true',
		enable  => true,
		require => Package[''],
	}

}




EOT

echo -n "Give module description: "
read COMMENT

echo "## Module $HANDLE" >> $HANDLE/readme.md
echo $COMMENT >> $HANDLE/readme.md

cd ..

echo $HANDLE " module and subfolders created"
