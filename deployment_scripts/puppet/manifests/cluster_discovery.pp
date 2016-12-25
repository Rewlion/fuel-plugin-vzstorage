# current manifest installs and configures bind as dns backend  to provide cluster discovery
# dns server will be installed on master-mds

$vzstorage          = hiera('vzstorage')
$cluster_name       = vzstorage['cluster_name']
$network_scheme 	= hiera('network_scheme:')
$master_ip   		= network_scheme['endpoints']['br-storage']['IP']
$mds 				= vzstorage::get_mds_ips(hiera('nodes'))
$zone 				= "${cluster_name}.vz"

file {"/var/named/${zone}.zone":
  ensure  => file,
  content => template('cluster.zone.erb'),
}

include bind
bind::server::conf { '/etc/named.conf':
  listen_on_addr    => [ 'any' ],
  listen_on_v6_addr => [ 'any' ],
  allow_query       => [ 'any' ],
  zones             => {
    "${zone}" => [
      'type master',
      "file \"${zone}.zone\"",
    ],
  },
}