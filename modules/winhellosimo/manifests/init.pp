class winhellosimo {
	
	file { 'c:\hellosimo.txt':
		content => "Hello Simo!\n",
	}
	file { 'C:\\ProgramData\\Microsoft\\Windows\\Start Menu\\Programs\\StartUp\\SetupCompleteStartUp.cmd':
		ensure => absent,
	}
}

