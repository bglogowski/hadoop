class hadoop::config (
    String $hadoop_version,
    String $hadoop_cluster
  ) {

  $namenodes = query_nodes("hadoop.installed=true and hadoop.cluster=${hadoop_cluster} and hadoop.roles.namenode=true")
  $datanodes = query_nodes("hadoop.installed=true and hadoop.cluster=${hadoop_cluster} and hadoop.roles.datanode=true")
  $journalnodes = query_nodes("hadoop.installed=true and hadoop.cluster=${hadoop_cluster} and hadoop.roles.journalnode=true")
  $zookeepers = query_nodes("zookeeper.installed=true and zookeeper.cluster=${hadoop_cluster}")

  $hdfs_blocksize  = lookup( 'hadoop.hdfs.blocksize' )
  $hdfs_administrators  = lookup( 'hadoop.hdfs.administrators' )

  $hdfs_nn_chkpt_dir  = lookup( 'hadoop.hdfs.namenode.directories.checkpoint' )
  $hdfs_nn_edits_dir  = lookup( 'hadoop.hdfs.namenode.directories.edits' )
  $hdfs_nn_name_dir   = lookup( 'hadoop.hdfs.namenode.directories.name' )
  $hdfs_nn_http_port  = lookup( 'hadoop.hdfs.namenode.ports.http' )
  $hdfs_nn_https_port = lookup( 'hadoop.hdfs.namenode.ports.https' )
  $hdfs_nn_rpc_port   = lookup( 'hadoop.hdfs.namenode.ports.rpc' )

  $hdfs_dn_data_dir   = lookup( 'hadoop.hdfs.datanode.directories.data' )
  $hdfs_dn_hdfs_port  = lookup( 'hadoop.hdfs.datanode.ports.hdfs' )
  $hdfs_dn_http_port  = lookup( 'hadoop.hdfs.datanode.ports.http' )
  $hdfs_dn_https_port = lookup( 'hadoop.hdfs.datanode.ports.https' )
  $hdfs_dn_ipc_port   = lookup( 'hadoop.hdfs.datanode.ports.ipc' )

  $hdfs_jn_http_port  = lookup( 'hadoop.hdfs.journalnode.ports.http' )
  $hdfs_jn_https_port = lookup( 'hadoop.hdfs.journalnode.ports.https' )
  $hdfs_jn_rpc_port = lookup( 'hadoop.hdfs.journalnode.ports.rpc' )


  file { '/etc/hadoop/':
    ensure => 'directory',
    owner  => 'root',
    group  => 'hadoop',
    mode   => '0750',
  }

  file { '/etc/hadoop/conf/':
    ensure  => 'directory',
    owner   => 'root',
    group   => 'hadoop',
    mode    => '0750',
    require => File['/etc/hadoop/'],
  }

  file { '/etc/hadoop/conf/.cluster':
    ensure  => 'file',
    owner   => 'root',
    group   => 'hadoop',
    mode    => '0640',
    content => $hadoop_cluster,
    require => File['/etc/hadoop/conf/'],
  }

  file { '/etc/hadoop/conf/capacity-scheduler.xml':
    ensure  => 'file',
    owner   => 'root',
    group   => 'hadoop',
    mode    => '0640',
    content => template("hadoop/${hadoop_version}/capacity-scheduler.xml.erb"),
    require => File['/etc/hadoop/conf/'],
  }

  file { '/etc/hadoop/conf/configuration.xsl':
    ensure  => 'file',
    owner   => 'root',
    group   => 'hadoop',
    mode    => '0640',
    content => template("hadoop/${hadoop_version}/configuration.xsl.erb"),
    require => File['/etc/hadoop/conf/'],
  }

  file { '/etc/hadoop/conf/container-executor.cfg':
    ensure  => 'file',
    owner   => 'root',
    group   => 'hadoop',
    mode    => '0640',
    content => template("hadoop/${hadoop_version}/container-executor.cfg.erb"),
    require => File['/etc/hadoop/conf/'],
  }

  file { '/etc/hadoop/conf/core-site.xml':
    ensure  => 'file',
    owner   => 'root',
    group   => 'hadoop',
    mode    => '0640',
    content => template("hadoop/${hadoop_version}/core-site.xml.erb"),
    require => File['/etc/hadoop/conf/'],
  }

  file { '/etc/hadoop/conf/hadoop-env.sh':
    ensure  => 'file',
    owner   => 'root',
    group   => 'hadoop',
    mode    => '0640',
    content => template("hadoop/${hadoop_version}/hadoop-env.sh.erb"),
    require => File['/etc/hadoop/conf/'],
  }

  file { '/etc/hadoop/conf/hadoop-metrics2.properties':
    ensure  => 'file',
    owner   => 'root',
    group   => 'hadoop',
    mode    => '0640',
    content => template("hadoop/${hadoop_version}/hadoop-metrics2.properties.erb"),
    require => File['/etc/hadoop/conf/'],
  }

  file { '/etc/hadoop/conf/hadoop-metrics.properties':
    ensure  => 'file',
    owner   => 'root',
    group   => 'hadoop',
    mode    => '0640',
    content => template("hadoop/${hadoop_version}/hadoop-metrics.properties.erb"),
    require => File['/etc/hadoop/conf/'],
  }

  file { '/etc/hadoop/conf/hadoop-policy.xml':
    ensure  => 'file',
    owner   => 'root',
    group   => 'hadoop',
    mode    => '0640',
    content => template("hadoop/${hadoop_version}/hadoop-policy.xml.erb"),
    require => File['/etc/hadoop/conf/'],
  }

  file { '/etc/hadoop/conf/hdfs-site.xml':
    ensure  => 'file',
    owner   => 'root',
    group   => 'hadoop',
    mode    => '0640',
    content => template("hadoop/${hadoop_version}/hdfs-site.xml.erb"),
    require => File['/etc/hadoop/conf/'],
  }

  file { '/etc/hadoop/conf/httpfs-env.sh':
    ensure  => 'file',
    owner   => 'root',
    group   => 'hadoop',
    mode    => '0640',
    content => template("hadoop/${hadoop_version}/httpfs-env.sh.erb"),
    require => File['/etc/hadoop/conf/'],
  }

  file { '/etc/hadoop/conf/httpfs-log4j.properties':
    ensure  => 'file',
    owner   => 'root',
    group   => 'hadoop',
    mode    => '0640',
    content => template("hadoop/${hadoop_version}/httpfs-log4j.properties.erb"),
    require => File['/etc/hadoop/conf/'],
  }

  file { '/etc/hadoop/conf/httpfs-signature.secret':
    ensure  => 'file',
    owner   => 'root',
    group   => 'hadoop',
    mode    => '0640',
    content => template("hadoop/${hadoop_version}/httpfs-signature.secret.erb"),
    require => File['/etc/hadoop/conf/'],
  }

  file { '/etc/hadoop/conf/httpfs-site.xml':
    ensure  => 'file',
    owner   => 'root',
    group   => 'hadoop',
    mode    => '0640',
    content => template("hadoop/${hadoop_version}/httpfs-site.xml.erb"),
    require => File['/etc/hadoop/conf/'],
  }

  file { '/etc/hadoop/conf/kms-acls.xml':
    ensure  => 'file',
    owner   => 'root',
    group   => 'hadoop',
    mode    => '0640',
    content => template("hadoop/${hadoop_version}/kms-acls.xml.erb"),
    require => File['/etc/hadoop/conf/'],
  }

  file { '/etc/hadoop/conf/kms-env.sh':
    ensure  => 'file',
    owner   => 'root',
    group   => 'hadoop',
    mode    => '0640',
    content => template("hadoop/${hadoop_version}/kms-env.sh.erb"),
    require => File['/etc/hadoop/conf/'],
  }

  file { '/etc/hadoop/conf/kms-log4j.properties':
    ensure  => 'file',
    owner   => 'root',
    group   => 'hadoop',
    mode    => '0640',
    content => template("hadoop/${hadoop_version}/kms-log4j.properties.erb"),
    require => File['/etc/hadoop/conf/'],
  }

  file { '/etc/hadoop/conf/kms-site.xml':
    ensure  => 'file',
    owner   => 'root',
    group   => 'hadoop',
    mode    => '0640',
    content => template("hadoop/${hadoop_version}/kms-site.xml.erb"),
    require => File['/etc/hadoop/conf/'],
  }

  file { '/etc/hadoop/conf/log4j.properties':
    ensure  => 'file',
    owner   => 'root',
    group   => 'hadoop',
    mode    => '0640',
    content => template("hadoop/${hadoop_version}/log4j.properties.erb"),
    require => File['/etc/hadoop/conf/'],
  }

  file { '/etc/hadoop/conf/mapred-env.sh':
    ensure  => 'file',
    owner   => 'root',
    group   => 'hadoop',
    mode    => '0640',
    content => template("hadoop/${hadoop_version}/mapred-env.sh.erb"),
    require => File['/etc/hadoop/conf/'],
  }

  file { '/etc/hadoop/conf/slaves':
    ensure  => 'file',
    owner   => 'root',
    group   => 'hadoop',
    mode    => '0640',
    content => template("hadoop/${hadoop_version}/slaves.erb"),
    require => File['/etc/hadoop/conf/'],
  }

  file { '/etc/hadoop/conf/yarn-env.sh':
    ensure  => 'file',
    owner   => 'root',
    group   => 'hadoop',
    mode    => '0640',
    content => template("hadoop/${hadoop_version}/yarn-env.sh.erb"),
    require => File['/etc/hadoop/conf/'],
  }

  file { '/etc/hadoop/conf/yarn-site.xml':
    ensure  => 'file',
    owner   => 'root',
    group   => 'hadoop',
    mode    => '0640',
    content => template("hadoop/${hadoop_version}/yarn-site.xml.erb"),
    require => File['/etc/hadoop/conf/'],
  }

}
