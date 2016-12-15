
class vzstorage::metadata_server($type) {
	if !( $type in ['master', 'slave'] ) {
		fail('vzstorage::metadata_server::wrong argument')
	}

	$vzstorage          = hiera('vzstorage')
	$network_scheme 	  = hiera('network_scheme:')
	$node_storage_ip    = network_scheme['endpoints']['br-storage']['IP']
	$cluster_name       = vzstorage['cluster_name']
	$cluster_password   = vzstorage['cluster_password']
	$vzstorage_data_dir = "/vzstorage"

	package{'vstorage-metadata-server':
    	ensure => present,
	}

	file{ '$vzstorage_data_dir':
	  ensure => 'directory',
	}

	case $type {
		'master': { 
			exec{ 'setup master mds':
  				cmd => 'echo ${cluster_password} | vstorage -c ${cluster_name} \
		        		make-mds -I -a ${node_storage_ip} \
		                -r ${vzstorage_data_dir}/${cluster_name}-mds -P' , 
		    }
		}
		
		'slave': { 
			exec{ 'authorize to cluster':
				cmd => 'echo ${cluster_password} | vstorage -c ${cluster_name} auth-node'
			}

			exec{ 'setup additional mds':
  				cmd => 'vstorage -c ${cluster_name} \
		        		make-mds -a ${node_storage_ip} \
		                -r ${vzstorage_data_dir}/${cluster_name}-mds' , 
		    }	
		}

		default: fail('vzstorage::metadata_server::wrong argument')
	}

	service{ 'vstorage-mdsd.target':
  		ensure => running,
  		enable => true,
	}->
}