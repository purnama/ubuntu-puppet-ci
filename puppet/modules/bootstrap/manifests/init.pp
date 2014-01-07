class bootstrap {
    # this makes puppet and vagrant shut up about the puppet group
        group { 'puppet':
        ensure => 'present'
    }

    # make sure the packages are up to date before beginning
    exec { 'apt-get update':
        command => '/usr/bin/apt-get update',
    }

    # List all package need to be installed
    $packages = ["curl", "vim", "subversion", "git", "make", "maven", "alien", 
        "libaio1", "unixodbc", "unzip", "bc", "zip", "openjdk-7-jdk", "openjdk-7-source", 
        "openjdk-7-demo", "openjdk-7-doc", "openjdk-7-jre-headless", "openjdk-7-jre-lib", 
        "tomcat7"]

}