class sxw::envsetup {
  package { 'snmpd':; }
  service { 'snmpd':
    ensure  => running,
    enable  => true,
    require => Package['snmpd'],
  }
  file { '/etc/snmp/snmpd.conf':
    ensure  => file,
    source  => 'puppet:///modules/sxw/snmpd.conf',
    require => Package['snmpd'],
    notify  => Service['snmpd'],
  }
  file { '/etc/default':
    ensure => directory,
  }
  file { '/etc/default/snmpd':
    ensure  => file,
    source  => 'puppet:///modules/sxw/defualt-snmpd',
    require => Package['snmpd'],
    notify  => Service['snmpd'],
  }
}