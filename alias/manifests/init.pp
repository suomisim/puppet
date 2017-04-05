class alias {

	file {"home/suomisim/.bashrc":
	 content => template('alias/alias.erb'),

	}

}
