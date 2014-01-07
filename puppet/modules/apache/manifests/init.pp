class apache{

	package { "apache2":
		ensure => present,
		require => Exec["install sonar"];
	}

	service { "apache2":
		ensure => running,
		require => Package["apache2"];
	}
       
        exec { 
		"sudo a2enmod proxy":
			unless => "/bin/readlink -e /etc/apache2/mods-enabled/proxy.load",
			require => Package["apache2"];
		"sudo a2enmod proxy_http":
			unless => "/bin/readlink -e /etc/apache2/mods-enabled/proxy_http.load",
			require => Exec["sudo a2enmod proxy"];
		"sudo a2dissite default":
               		onlyif => "/bin/readlink -e /etc/apache2/sites-enabled/000-default",
			require => Exec["sudo a2enmod proxy_http"];
		"sudo a2ensite continuous-integration":
			unless => "/bin/readlink -e /etc/apache2/sites-enabled/continuous-integration",
			require => File["/etc/apache2/sites-available/continuous-integration"];
	}

	file {
		"/etc/apache2/sites-available/continuous-integration":
			source => "puppet:///modules/apache/continuous-integration",
			owner => "www-data",
			group => "www-data",
			ensure => file,
			require => Exec["sudo a2dissite default"];
	}

}
