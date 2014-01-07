class bootstrap {
    # this makes puppet and vagrant shut up about the puppet group
        group { 'puppet':
        ensure => 'present'
    }

    # List all package need to be installed
    $packages = ["curl", "vim", "subversion", "make", "maven", "alien", "default-jre-headless", 
        "libaio1", "unzip", "bc", "zip", "openjdk-7-jdk", "openjdk-7-source", 
        "openjdk-7-demo", "openjdk-7-doc", "openjdk-7-jre-headless", "openjdk-7-jre-lib"]

    # Install listed package
    package { $packages:
        ensure => present
    }

}
