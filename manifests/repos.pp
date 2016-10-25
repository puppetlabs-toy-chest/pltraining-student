class student::repos {
  yumrepo { 'puppetlabs':
    baseurl             => 'http://yum.puppetlabs.com/el/6/products/$basearch/',
    enabled             => '0',
    priority            => '99',
    gpgcheck            => '0',
    skip_if_unavailable => '1',
    descr               => 'Puppetlabs yum repo'
  }
  package { 'yum-plugin-priorities':
    ensure => installed,
  }
  augeas { 'enable_yum_priorities':
    context => '/files/etc/yum/pluginconf.d/priorities.conf/main',
    changes => [
      "set enabled 1",
    ],
    require => Package['yum-plugin-priorities'],
  }
  yumrepo { [ 'updates', 'base', 'extras']:
    enabled  => '0',
    priority => '99',
    skip_if_unavailable => '1',
  }
}
