class vzstorage::ssd_partition($dev_list){
  $vzstorage    = hiera('vzstorage')
  $cluster_name = vzstorage['cluster_name']

  dev_list.each |$id, $dev| {
   
    exec{ 'partition ${id}':
      cmd => 'echo y | /usr/libexec/vstorage/prepare_vstorage_drive ${dev} --noboot --ssd'
    }
  
    $uuid = get_dev_uuid($dev)

    file_line { 'add new partition':
      path => '/etc/fstab',
      line => 'UUID=${uuid} /vstorage/${cluster_name}-cs{id}    ext4  defaults,lazytime   1 2',
    }
    /vstorage/<cluster>-cs<N>

    exec{ 'mount partition':
      cmd => 'mount ${dev} /vzstorage/{cluster_name}-ssd${id}'
    }
  }
}