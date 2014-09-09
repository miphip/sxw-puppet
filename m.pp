include sxw-common

class sxw-dev {
  require sxw-common, sxw-devtools
}

class sxw-common {
  package { 'python-software-properties': }
  package {
    'subversion':;
    'git':;
    'openssh-server':;
    'zip':;
    'samba':;
    'bison':;
    'gettext':;
    'flex':;
    'libncurses5-dev':;
    'manpages-dev':;
    'build-essential':;
    'fakeroot':;
    'rsh-client':;
    'texinfo':;
    'language-pack-en':;
    'valgrind':;
    'quilt':;
    'automake':;
    'binutils-dev':;
    'gawk':;
    'texlive':;
    'texlive-latex-extra':;
    'openjdk-7-jdk':;
    'python3':;
    'python-dev':;
    'gcc-4.6':;
    'g++-4.6':;
    'liblua5.1-0-dev':;
    'libusb-1.0-0-dev':;
    'libssh2-1-dev':;
    'libssl-dev':;
    'smbclient':;
    'libcap-dev':;
    'libc6-i386':;
    'libusb-dev':;
    'python-virtualenv':;
  }

  class { 'sxw-nfssetup-trusty':
    user => 'ci',
  }

  require sxw-perlsetup
#    sxw-mknod
}

class sxw-nfssetup-trusty ($user) {
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

class sxw-perlsetup {
  include cpan
  package { 'perl':
    ensure => installed,
  }
  cpan { 'Math::Expressions':
    require => Package['perl'],
  }
  cpan { 'IO::Pty':
    require => Package['perl'],
  }
  cpan { 'Expect':
    require => Package['perl'],
  }
}