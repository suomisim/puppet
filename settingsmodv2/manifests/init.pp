class settingsmodv2 {

	file {'/home/suomisim/.config/xfce4/panel/whiskermenu-1.rc':
		content => template('settingsmodv2/whiskermenu-1.rc.erb')

	}

	file {'/home/suomisim/.config/xfce4/terminal/terminalrc':
		content => template('settingsmodv2/terminalrc.erb')

	}

	file {'/home/suomisim/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml':
		content => template('settingsmodv2/xfce4-panel.xml.erb')

	}

}
