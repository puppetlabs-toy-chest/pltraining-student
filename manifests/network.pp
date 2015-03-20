class student::network{
  
  service { 'sshd':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }

  # Make sure the firewall isn't running
  service { 'iptables':
    enable => false,
    ensure => stopped,
  }
  
  # Disable GSSAPIAuth for training VM.
  # The learning VM has a quest that relates to this, so leave
  # it enabled for the LVM.
  augeas { "GSSAPI_disable":
    context => '/files/etc/ssh/sshd_config',
    changes => 'set GSSAPIAuthentication no',
  }

  file { '/etc/sysconfig/network':
    ensure  => file,
    content => template('bootstrap/network.erb'),
  }
  service { 'network':
    ensure    => running,
    enable    => true,
    subscribe => File['/etc/sysconfig/network'],
    hasstatus => true,
  }
}
