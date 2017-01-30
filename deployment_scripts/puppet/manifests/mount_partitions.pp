# Current manifest mounts partitions for chunk server
#
# Fuel doesn't allow to specify unic web-ui variables for nodes
# so we just try to mount all mentioned devs in metadata variable

$vzstorage    = hiera('vzstorage')
$cluster_name = vzstorage['cluster_name']
$hdd_list     = split(vzstorage('hdd_storage_devices'), ',')

/vstorage/<cluster>-cs<N>
$hdd_list.each |$id, $dev|{
  file { '/vstorage/${cluster_name}-cs${id}':
    ensure => 'directory',
  }
  exec{ 'mount partition':
    cmd => 'mount ${dev} /vzstorage/{cluster_name}-cs${id}'
  }
}