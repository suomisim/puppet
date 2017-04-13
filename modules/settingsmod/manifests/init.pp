class settingsmod {

	file {'/home/suomisim/.config/xfce4/panel/whiskermenu-1.rc':
		content => template('settingsmod/whiskermenu-1.rc.erb')

	}

	file {'/home/suomisim/.config/xfce4/terminal/terminalrc':
		content => template('settingsmod/terminalrc.erb')

	}


}
