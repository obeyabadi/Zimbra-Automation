class zimbra8::install {

#$RANDOMHAM="MGUyNTE1OD"
#$RANDOMSPAM="MGUyNTE1OD"
#$RANDOMVIRUS="MGUyNTE1OD"

$host=$::hostname
$ip_address=$::ipaddress
$domain=$::domain
$password="admin@123"

	file { '/tmp/installZimbraScript' :
		ensure => "file",
		content => template('zimbra8/installZimbraScript'),
		}

	file { '/tmp/installZimbra-keystrokes' :
		ensure => "file",
		source => 'puppet:///modules/zimbra8/installZimbra-keystrokes',
		}

}
