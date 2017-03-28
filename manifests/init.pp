class hadoop (
    String $hadoop_version = '2.7.3',
    String $hadoop_cluster = 'default',
    Array  $hadoop_role    = [ 'datanode', 'historyserver', 'journalnode', 'namenode', 'nodemanager', 'resourcemanager', 'timelineserver', 'zkfc' ]
  ) {

  [ 'hadoop', 'hdfs', 'yarn', 'mapred' ].each |String $user| {

    hadoop::users { $user:
      username => $user,
      before   => Class['hadoop::install'],
    }

  }

  class { 'hadoop::install':
    hadoop_version => $hadoop_version,
  }

  class { 'hadoop::config':
    hadoop_version => $hadoop_version,
    hadoop_cluster => $hadoop_cluster,
    require        => Class['hadoop::install'],
  }

  $hadoop_role.each |String $role| {

    hadoop::role::assign { $role:
      hadoop_role => $role,
      require     => Class['hadoop::config'],
    }

  }

}
