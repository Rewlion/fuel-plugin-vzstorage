# current manifest configures namespace to use dns from master-mds
vzstorage_dns = vzstorage::get_vzstorage_dns(hiera('nodes'))

file_line{ 'add search conf':
	ensure => present,
	line => "search vz.test",
	path => '/etc/resolf.conf',
}->
file_line{ 'add dns ip':
	ensure => present,
	line => "namespace ${vzstorage_dns}",
	path => '/etc/resolf.conf',
}