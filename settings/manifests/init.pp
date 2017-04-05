class settings {

	file {'/home/suomisim/.config/xfce4/panel/whiskermenu-1.rc':
		content => template('settings/whiskermenu-1.rc.erb')

	}

	file {'/home/suomisim/.config/xfce4/terminal/terminalrc':
		content => template('settings/terminalrc.erb')

	}


}
