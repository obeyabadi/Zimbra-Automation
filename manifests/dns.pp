class zimbra8::dns {
$host=$::hostname
$ip_address=$::ipaddress
$domain=$::domain	
	exec { 'install zimbra dependecies' :
		cwd => "/root",
		path => '/usr/bin:/usr/sbin:/bin',
		command => "yum update -y && yum install -y perl net-tools nc unzip sysstat openssh-clients perl-core libaio nmap-ncat libstdc++.so.6 wget",
		timeout => 7200,
		}

	service { 'postfix' :
		ensure => stopped,
		enable => false,
		}

	package	{ 'bind' :
		ensure => installed,
		}

	 package { 'bind-utils' :
                ensure => installed,
                }

	file { '/etc/resolv.conf' :
		ensure => "file",
		content => template('zimbra8/resolv.conf'),
		}	
	
	file { '/etc/named.conf' :
		ensure => "file",
		content => template('zimbra8/named.conf'),
		}
	
	file { '/var/named/fwd' :
		ensure => "file",
		content => template('zimbra8/fwd'),
		}

	service { 'named' :
		ensure => running,
		enable => true,
		}
	
	package { 'dnsmasq' :
		ensure => installed,
		}
	
	file { '/etc/dnsmasq.conf' :
		ensure => "file",
		content => template('zimbra8/dnsmasq.conf'),
		}

	service { 'dnsmasq' :
		ensure => stopped,
		enable => false,
		}
}
