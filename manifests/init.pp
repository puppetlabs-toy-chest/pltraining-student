class student {
  # ILT training-specific setup
  File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }



  file { '/usr/bin/envpuppet':
    source => 'puppet:///modules/bootstrap/envpuppet',
    mode   => '0755',
  }


  # Add a few extra packages for convenience
  package { [ 'patch', 'screen', 'telnet', 'tree', 'wget' ] :
    ensure  => present,
    require => Class['localrepo'],
  }

  # /etc/puppet/ssl is confusing to have around. Sloppy. Kill.
  file {'/etc/puppet':
    ensure  => absent,
    recurse => true,
    force   => true,
  }



  # Cache forge modules locally in the vm:
  class { 'bootstrap::cache_modules': cache_dir => '/usr/src/forge' }

  # Cache gems locally in the vm:
  class { 'bootstrap::cache_gems': }

  # configure user environment
  include userprefs::defaults

  # create local repos
  include localrepo

  # Add helper scripts
  include student::scripts

  # Yum related config
  include student::repos

  # Ruby related settings
  include student::ruby_settings

  # Network setttings
  include student::network
}

