class sxw::mknod {
  file { '/opt/tac/bin/mknod_cvt_vtl':
    ensure => file,
    source => 'puppet:///modules/sxw/mknod_cvt_vtl',
  }
}
