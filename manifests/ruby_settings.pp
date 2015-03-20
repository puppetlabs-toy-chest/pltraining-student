class student::ruby_settings{
  package { 'ruby_augeas_lib':
    ensure  => 'present',
    name    => $ruby_aug_package,
    require => Class['localrepo']
  }
  # Disable GSS-API for SSH to speed up log in
  $ruby_aug_package = $::osfamily ? {
    'RedHat' => 'ruby-augeas',
    'Debian' => 'libaugeas-ruby',
  }
  # need rubygems to cache rubygems
  package { 'rubygems' :
    ensure  => present,
    require => Class['localrepo'],
    before  => Class['bootstrap::cache_gems'],
  }
}
