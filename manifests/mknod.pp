class sxw::mknod {
  file { '/opt/tac':
    ensure => directory,
  }
  file { '/opt/tac/bin':
    ensure => directory,
  }
  file { '/opt/tac/bin/mknod_cvt_vtl':
    ensure  => file,
    source  => 'puppet:///modules/sxw/mknod_cvt_vtl',
  }
}
