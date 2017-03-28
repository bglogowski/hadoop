
class hadoop::install ( $hadoop_version ) {

  $mirror = lookup( "mirrors.apache.${fqdn_rand(10)}" )
  $checksum = lookup( 'checksums.hadoop' )[$hadoop_version]['sha256']

  if ($facts['hadoop']['installed'] == true) and ($facts['hadoop']['version'] == $hadoop_version) {

    file {"/var/tmp/hadoop-${hadoop_version}.tar.gz":
      ensure => 'absent',
      backup => false,
    }

    file { '/usr/libexec/hadoop-config.sh':
      ensure => 'file',
      mode   => '0755',
    }

    file { '/usr/libexec/hadoop-layout.sh':
      ensure => 'file',
      mode   => '0755',
    }

    file { '/usr/sbin/hadoop-daemon.sh':
      ensure => 'link',
      owner  => 'root',
      group  => 'root',
      mode   => '0755',
      target => '/opt/hadoop/sbin/hadoop-daemon.sh',
    }

    file { '/usr/sbin/yarn-daemon.sh':
      ensure => 'link',
      owner  => 'root',
      group  => 'root',
      mode   => '0755',
      target => '/opt/hadoop/sbin/yarn-daemon.sh',
    }

    file { '/usr/local/bin/container-executor':
      ensure => 'link',
      owner  => 'root',
      group  => 'root',
      mode   => '0755',
      target => '/opt/hadoop/bin/container-executor',
    }

    file { '/usr/local/bin/hadoop':
      ensure => 'link',
      owner  => 'root',
      group  => 'root',
      mode   => '0755',
      target => '/opt/hadoop/bin/hadoop',
    }

    file { '/usr/local/bin/hdfs':
      ensure => 'link',
      owner  => 'root',
      group  => 'root',
      mode   => '0755',
      target => '/opt/hadoop/bin/hdfs',
    }

    file { '/usr/local/bin/mapred':
      ensure => 'link',
      owner  => 'root',
      group  => 'root',
      mode   => '0755',
      target => '/opt/hadoop/bin/mapred',
    }

    file { '/usr/local/bin/rcc':
      ensure => 'link',
      owner  => 'root',
      group  => 'root',
      mode   => '0755',
      target => '/opt/hadoop/bin/rcc',
    }

    file { '/usr/local/bin/test-container-executor':
      ensure => 'link',
      owner  => 'root',
      group  => 'root',
      mode   => '0755',
      target => '/opt/hadoop/bin/test-container-executor',
    }

    file { '/usr/local/bin/yarn':
      ensure => 'link',
      owner  => 'root',
      group  => 'root',
      mode   => '0755',
      target => '/opt/hadoop/bin/yarn',
    }

  } else {

    file { "/var/tmp/hadoop-${hadoop_version}.tar.gz":
      ensure         => 'present',
      owner          => 'root',
      group          => 'root',
      mode           => '0644',
      checksum       => 'sha256',
      checksum_value => $checksum,
      backup         => false,
      source         => "http://${mirror}/hadoop/common/hadoop-${hadoop_version}/hadoop-${hadoop_version}.tar.gz",
      notify         => Exec["untar hadoop-${hadoop_version}"],
    }

    exec { "untar hadoop-${hadoop_version}":
      command     => "/bin/tar xf /var/tmp/hadoop-${hadoop_version}.tar.gz",
      cwd         => '/opt',
      refreshonly => true,
      require     => File["/var/tmp/hadoop-${hadoop_version}.tar.gz"],
      notify      => Exec["chown hadoop-${hadoop_version}"],
    } ->

    exec { "chown hadoop-${hadoop_version}":
      command     => "/bin/chown -R root:root /opt/hadoop-${hadoop_version}",
      cwd         => '/opt',
      refreshonly => true,
      require     => File["/var/tmp/hadoop-${hadoop_version}.tar.gz"],
    } ->

    file { '/opt/hadoop':
      ensure  => 'link',
      target  => "/opt/hadoop-${hadoop_version}",
      require => File["/var/tmp/hadoop-${hadoop_version}.tar.gz"],
    }

  }

}
