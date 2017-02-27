$vzstorage 	 = hiera('vzstorage')
$network_scheme  = hiera('network_scheme')
$node_storage_ip = $network_scheme['endpoints']['br-storage']['IP']
$cluster_name	 = $vzstorage['cluster_name']
$type		 = 'master'

class { 'vzstorage_mds': 
	type 		 => $type,
	storage_ip 	 => $node_storage_ip,
	cluster_name 	 => $cluster_name,
	cluster_password => $cluster_password,
}
	
