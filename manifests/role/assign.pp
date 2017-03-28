define hadoop::role::assign ( String $hadoop_role ) {

  if $facts['os']['family'] == 'RedHat' {
    $system_dir = '/usr/lib/systemd/system/'
  } else {
    $system_dir = '/lib/systemd/system/'
  }

  file { "/etc/hadoop/conf/.${hadoop_role}":
    ensure  => 'file',
    owner   => 'root',
    group   => 'hadoop',
    mode    => '0640',
    require => File['/etc/hadoop/conf/'],
  }

  file { "hadoop-${hadoop_role}.service":
    ensure  => 'file',
    path    => "${system_dir}/hadoop-${hadoop_role}.service",
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("hadoop/${hadoop_role}/hadoop-${hadoop_role}.service.erb"),
  }

  service { "hadoop-${hadoop_role}":
    ensure  => 'stopped',
    enable  => false,
    require => File["hadoop-${hadoop_role}.service"],
  }

}
