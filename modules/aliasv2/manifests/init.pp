class alias {

	file {'/etc/bash.bashrc':
		content => template('alias/bash.bashrc.erb')

	}

}
