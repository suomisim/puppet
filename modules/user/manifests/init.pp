class user {
	
  # add user, create homedir and set a password
  
	user { 'wordpressuser':
		ensure     => 'present',
		comment    => 'Wordpress user without a home folder',
		managehome => true,
		password   => 'wpuser',
	}

}




