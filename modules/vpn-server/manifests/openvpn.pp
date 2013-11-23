# == Class: vpn-server::openvpn
#
# Configures a openvpn VPN server
#
# === Parameters
#
# === Variables
#
# === Examples
#
#  class { vpn-server::openvpn: }
#
# === Authors
#
# Dan Fruehauf <malkodan@gmail.com>
#
# === Copyright
#
# Copyright 2013 Dan Fruehauf
#
class vpn-server::openvpn {
	if ! defined(Package[openvpn]) { package { openvpn: ensure => installed; } }
	service {
		openvpn:
			ensure  => running,
			enable  => true,
			require => Package[openvpn];
	}

	file { "/etc/openvpn/server.conf":
		content => template("vpn-server/openvpn/server.conf.erb"),
		owner   => root,
		group   => root,
		mode    => 0644,
		notify  => Service[openvpn],
	}

	file { "/etc/openvpn/auth-user.sh":
		source  => "puppet:///modules/vpn-server/openvpn/auth-user.sh",
		owner   => root,
		group   => root,
		mode    => 0755,
		notify  => Service[openvpn],
	}

	# user sample configuration and keys
	define openvpn_config_file ($src) {
		$openvpn_conf_dir = "/etc/openvpn"

		exec { "${openvpn_conf_dir}/${title}":
			command => "/bin/cp -a /usr/share/doc/openvpn-2.3.2/sample/${src}/${title} ${openvpn_conf_dir}/${title} && chmod 400 ${openvpn_conf_dir}/${title}",
			notify  => Service[openvpn],
			creates => "${openvpn_conf_dir}/${title}",
		}
	}

	# sample configuration
	#openvpn_config_file { "server.conf": src => "sample-config-files" }
	openvpn_config_file { "dh1024.pem":  src => "sample-keys" }
	openvpn_config_file { "ca.crt":      src => "sample-keys" }
	openvpn_config_file { "server.crt":  src => "sample-keys" }
	openvpn_config_file { "server.key":  src => "sample-keys" }
}
