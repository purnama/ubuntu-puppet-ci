class jenkins {

	# Installing jenkins
	exec{
		"download jenkins apt-key":
			require => Package["openjdk-7-jdk"],
			cwd => "/home/ubuntu/",
			command => "wget -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -",
			unless => "sudo apt-key list | grep -c Kohsuke";
		"add jenkins repository to deb":
			require => Exec["download jenkins apt-key"],
			cwd => "/home/ubuntu/",
			command => "sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'",
			onlyif => "test ! -f /etc/apt/sources.list.d/jenkins.list";
		"update package jenkins":
			command => "apt-get update",
			require => Exec["add jenkins repository to deb"],
			unless => "dpkg -l | grep -c jenkins";
        }

	package {"jenkins":
		ensure => present,
		require => Exec["update package jenkins"];
	}

	file {
		"/etc/default/jenkins":
			source => "puppet:///modules/jenkins/jenkins",
			owner => "root",
			group => "root",
			ensure => file,
			require => Package["jenkins"],
			notify => Service["jenkins"];
	}

	service {"jenkins":
		ensure => running,
		require => Package["jenkins"];
	}

}
