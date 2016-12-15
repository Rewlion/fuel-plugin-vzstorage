class vzstorage::chunk_server{
	$vzstorage          = hiera('vzstorage')
	$cluster_name       = vzstorage['cluster_name']
	$cluster_password   = vzstorage['cluster_password']

	exec{ 'authorize to cluster':
		cmd => 'echo ${cluster_password} | vstorage -c ${cluster_name} auth-node',
	}

  exec{ 'setup chunk server': 
    cmd => 'vstorage -c ${cluster_name} make-cs -r /vstorage/${cluster_name}-cs',
  }
  
  service{ 'vstorage-mdsd.target':
      ensure => running,
      enable => true,
  }->
}