
$vzstorage = hiera('vzstorage')
$cluster_name = vzstorage['cluster_name']

cinder_config{
  "DEFAULT/enabled_backends":                       value=> "lvmdriver-1,vstorage-ploop,vstorage-qcow2";
  "vstorage-ploop/vzstorage_default_volume_format": value=> "parallels";
  "vstorage-ploop/vzstorage_shares_config":         value=> "/etc/cinder/vzstorage-shares-vstorage.conf";
  "vstorage-ploop/volume_driver":                   value=> "cinder.volume.drivers.vzstorage.VZStorageDriver";
  "vstorage-ploop/volume_backend_name":             value=> "vstorage-ploop";
  "vstorage-qcow2/vzstorage_default_volume_format": value=> "qcow2";
  "vstorage-qcow2/vzstorage_shares_config":         value=> "/etc/cinder/vzstorage-shares-vstorage.conf";
  "vstorage-qcow2/volume_driver":                   value=> "cinder.volume.drivers.vzstorage.VZStorageDriver";
  "vstorage-qcow2/volume_backend_name":             value=> "vstorage-qcow2";
}->
file{"/etc/cinder/vzstorage-shares-vstorage.conf":
  ensure => "exist",
  content => '$cluster_name ["-u", "cinder", "-g", "root", "-m", "0770"]'
}->
exec{"cinder type-create vstorage-qcow2":}->
exec{"cinder type-key vstorage-qcow2 set volume_backend_name=vstorage-qcow2":}->
exec{"cinder type-create vstorage-ploop":}->
exec{"cinder type-key vstorage-ploop set volume_backend_name=vstorage-ploop":}
~> 
Service[ openstack-cinder-api,
         openstack-cinder-scheduler,
         openstack-cinder-volume ]
