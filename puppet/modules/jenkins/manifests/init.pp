class jenkins {

	# Installing jenkins
	exec{
		"download jenkins apt-key":
			require => Package["openjdk-7-jdk"],
			cwd => "/home/ubuntu/",
			command => "wget http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add /home/ubuntu/jenkins-ci.org.key",
			creates => "/home/ubuntu/jenkins-ci.org.key";
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

	package{"jenkins":
		ensure => present,
		require => Exec["update package jenkins"];
	}

}
