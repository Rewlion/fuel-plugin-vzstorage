# installs mds 
#
# Parameters
#
# [type]
# Type of meta data server
# Valid argument: 'master', 'slave'
#
# [storage_ip]
# node's storage ip
#
# [cluster_name]
# vzstorage cluster's name
#
# [cluster_password]
# vzstorage cluster's password
#
# [vzstorage_dir] *Optional*
# journal's folder

class vzstorage::vzstorage_mds(	$type,
				$storage_ip,
				$cluster_name,
				$cluster_password,
				$vzstorage_dir = '/vzstorage')
{
  package{'vstorage-metadata-server':
      ensure => present,
  }

  file{ '$vzstorage_dir':
    ensure => 'directory',
  }

  case $type {
    'master': { 
      exec{ 'setup master mds':
          cmd => 'echo ${cluster_password} | vstorage -c ${cluster_name} \
                make-mds -I -a ${storage_ip} \
                    -r ${vzstorage_dir}/${cluster_name}-mds -P' , 
        }
    }
    'slave': { 
      exec{ 'authorize to cluster':
        cmd => 'echo ${cluster_password} | vstorage -c ${cluster_name} auth-node'
      }

      exec{ 'setup additional mds':
          cmd => 'vstorage -c ${cluster_name} \
                make-mds -a ${storage_ip} \
                    -r ${vzstorage_dir}/${cluster_name}-mds' , 
      } 
    }
  }

  service{ 'vstorage-mdsd.target':
      ensure => running,
      enable => true,
  }
}
