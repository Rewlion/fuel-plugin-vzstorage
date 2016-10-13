# this manifest confiugures minimal functioning setup 

$vzstorage          = hiera('vzstorage')
$cluster_name       = vzstorage['cluster_name']
$cluster_password   = vzstorage['cluster_password']
$vzstorage_data_dir = "/vzstorage"

file{ '$vzstorage_data_dir':
  ensure => 'directory',
}

exec{ 'vzstorage-mdsd settings':
  cmd => 'echo $cluster_password | vstorage -c $cluster_name \
          make-mds -I -a 127.0.0.1 \
          -r ${vzstorage_data_dir}/${cluster_name}-mds -P',
}

service{ 'vstorage-mdsd.target':
  ensure => running,
  enable => true,
}

exec{ 'echo 127.0.0.1 | tee /etc/vstorage/clusters/${cluster_name}/bs.list': }

exec{ 'vzstorage-csd settings':
  cmd => 'vstorage -c $cluster_name make-cs \
          -r $vzstorage_data_dir/$cluster_name-cs',
}

service{ 'vstorage-csd.target':
  ensure => running,
  enable => true,
}
