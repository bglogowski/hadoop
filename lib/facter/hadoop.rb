if File.exist? '/opt/hadoop'

  return_value = { 'installed' => true, 'version' => File.readlink('/opt/hadoop').split('-')[-1] }

  return_value['rsa_2048_keys'] = {}
  users = [ 'hadoop', 'hdfs', 'yarn', 'mapred' ]
  users.each do |user|
    if File.exist? "/home/#{user}/.ssh/id_rsa.pub"
      return_value['rsa_2048_keys'][user] = File.open("/home/#{user}/.ssh/id_rsa.pub", 'r') { |f| f.read }
    end
  end

  if File.exist? '/etc/hadoop/conf/.cluster'
    return_value['cluster'] = File.open('/etc/hadoop/conf/.cluster', 'r') { |f| f.read }
  end

  return_value['roles'] = {}
  roles = ['datanode','historyserver','journalnode','namenode','nodemanager','proxyserver','resourcemanager','secondarynamenode','timelineserver','zkfc']
  roles.each do |role|
    if File.exist? "/etc/hadoop/conf/.#{role}"
      return_value['roles'][role] = true
    else
      return_value['roles'][role] = false
    end
  end
  
  Facter.add(:hadoop) do
    setcode do
      return_value
    end
  end

else
  Facter.add(:hadoop) do
    setcode do
      { 'installed' => false }
    end
  end
end
