class sxw::envsetup {
  package { 'snmpd':; }
  service { 'snmpd':
    ensure  => running,
    enable  => true,
    require => Package['snmpd'],
  }
  file { '/etc/snmp/snmpd.conf':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    source  => 'puppet:///modules/sxw/snmpd.conf',
    require => Package['snmpd'],
    notify  => Service['snmpd'],
  }
  file { '/etc/default/snmpd':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    source  => 'puppet:///modules/sxw/default-snmpd',
    require => Package['snmpd'],
    notify  => Service['snmpd'],
  }
}
