class zimbra8 {

$host=$::hostname
$ip_address=$::ipaddress
$domain=$::domain
$password="admin@123"

	file { '/etc/hosts' :
		ensure => 'file',
		content => template('zimbra/hosts'),
		}

	exec { 'Get zimbra' : 
		cwd => "/root",
		path => '/usr/bin:/usr/sbin:/bin',
		command	=> "wget ftp://172.16.31.190/zcs-8.8.5_GA_1894.RHEL7_64.20171026035615.tgz && tar -xzvf zcs-8.8.5_GA_1894.RHEL7_64.20171026035615.tgz",
		creates => "/root/zcs-8.8.5_GA_1894.RHEL7_64.20171026035615.tgz",
		}

include zimbra8::dns
include zimbra8::install

	file { '/root/zimbra-install.sh' :
                ensure => 'file',
                mode   => '0777',
                source => 'puppet:///modules/zimbra8/zimbra-install',
                }


        exec { 'Install Zimbra' :
                cwd => "/root",
                path => '/usr/bin:/usr/sbin:/bin',
                command => "sh zimbra-install.sh ${domain} ${ip_address} ${password} ",
                timeout => 72000,
                creates => "/opt/zimbra/libexec",
		}

} 
