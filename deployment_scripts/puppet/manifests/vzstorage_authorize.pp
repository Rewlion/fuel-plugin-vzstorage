# this manifest authorize node to virtuozzo cluster

$vzstorage          = hiera('vzstorage')
$cluster_name       = vzstorage['cluster_name']
$cluster_password   = vzstorage['cluster_password']

exec{"authorize to vzstorage":
  cmd => '$ echo $cluster_password | vstorage -c $cluster_name auth-node -P'
}