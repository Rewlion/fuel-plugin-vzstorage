#current manifests prepares storage devices to be used by chunk server

$vzstorage = hiera('vzstorage')
$hdd_list  = split(vzstorage('hdd_storage_devices'), ',')
$ssd_list  = split(vzstorage('ssd_storage_devices'), ',')

class { 'hdd_partition': 
	dev_list => $hdd_list,
}

class { 'ssd_partition': 
	dev_list => $ssd_list,
}
