class student::scripts {
  # Populate the VM with our helper scripts.
  file {'/usr/local/bin':
    ensure  => directory,
    recurse => true,
    replace => false,
    mode    => '0755',
    source  => '/usr/src/puppetlabs-training-bootstrap/scripts/classroom',
  }
  # This is the thing Dom came up with to print the IP to the TTY
  file {'/root/.ip_info.sh':
    ensure => file,
    source => 'puppet:///modules/bootstrap/ip_info.sh',
    mode   => 0755,
  }
  # This script generates the initial root SSH key for the fundamentals git workflow
  file { '/root/.ssh_keygen.sh':
    ensure => file,
    source => 'puppet:///modules/bootstrap/ssh_keygen.sh',
    mode   => 0755,
  }
  # This shouldn't change anything, but want to make sure it actually IS laid out the way I expect.
  file {'/etc/rc.local':
    ensure => symlink,
    target => 'rc.d/rc.local',
    mode   => 0755,
  }
  # Make sure we run the ip_info script.
  file {'/etc/rc.d/rc.local':
    ensure  => file,
    content => template('bootstrap/rc.local.erb'),
    mode    => 0755,
  }
}
