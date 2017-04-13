
class { '::mysql::server':
  
  root_password           => 'strongpassword',
  remove_default_accounts => true,
  override_options        => $override_options

}
