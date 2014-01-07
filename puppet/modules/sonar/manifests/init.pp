class sonar {

        # Installing sonar
        exec{
                "add sonar repository to deb":
                        require => Package["jenkins", "default-jre-headless"],
                        command => "sh -c 'echo deb http://downloads.sourceforge.net/project/sonar-pkg/deb binary/ > /etc/apt/sources.list.d/sonar.list'",
                        unless => "dpkg -l | grep -c sonar",
                        onlyif => "test ! -f /etc/apt/sources.list.d/sonar.list";
                "update package sonar":
                        command => "apt-get update",
                        require => Exec["add sonar repository to deb"],
                        unless => "dpkg -l | grep -c sonar";
                "install sonar":
                        command => "apt-get install sonar --allow-unauthenticated",
			require => Exec["update package sonar"],
			unless => "dpkg -l | grep -c sonar";
        }
}
