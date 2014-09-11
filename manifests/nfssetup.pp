class sxw::nfssetup ($user) {
  user { nfs_user:
    name       => $user,
    ensure     => present,
    managehome => yes,
    shell      => '/bin/bash',
  }

  package { 'rpcbind':
    ensure => installed,
  }
  service { 'rpcbind':
    ensure  => running,
    enable  => 'true',
  }

  package { 'nfs-kernel-server':
    ensure => installed,
  }
  file_line { 'export /home':
    path    => '/etc/exports',
    line    => '/home *(rw,sync,no_root_squash,no_subtree_check,anonuid=65534,anongid=65533)',
    match   => '/home .*',
    require => Package['nfs-kernel-server'],
    notify  => Service['nfs-kernel-server'],
  }
  file_line { 'export /home/user':
    path    => '/etc/exports',
    line    => "/home/${user} *(rw,async,all_squash,no_subtree_check,anonuid=1000,anongid=1000)",
    match   => "/home/${user} .*",
    require => [Package['nfs-kernel-server'], User['nfs_user']],
    notify  => Service['nfs-kernel-server'],
  }
  service { 'nfs-kernel-server':
    ensure  => running,
    enable  => true,
    require => Service['rpcbind'],
  }
}
