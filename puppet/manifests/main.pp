# default path
Exec {
  path => ["/usr/bin", "/bin", "/usr/sbin", "/sbin", "/usr/local/bin", "/usr/local/sbin"]
}

$globalUser = 'vagrant'


node default{
    include bootstrap
    include jenkins
}
