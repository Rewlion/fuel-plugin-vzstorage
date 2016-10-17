#this manifest installs all required packages

$packages = [ vstorage-chunk-server,
              vstorage-client,
              vstorage-ctl,
              vstorage-libs-shared,
              vstorage-metadata-server,
              vstorage-kmod ]

$vzstorage_standalone_repo_pkg = "http://download.pstorage.parallels.com/standalone/packages/rhel/7/pstorage-release.noarch.rpm"

exec{ 'rpm -i $vzstorage_standalone_repo_pkg': }

packages.each |$package| {
  package{'$package':
    ensure => present,
  }
}

