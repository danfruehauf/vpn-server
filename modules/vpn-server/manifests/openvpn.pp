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
	$openvpn_conf_dir = "/etc/openvpn"

	if ! defined(Package[openvpn]) { package { openvpn: ensure => installed; } }
	if ! defined(Package[systemd]) { package { systemd: ensure => installed; } }

	# use systemd for service management
	service {
		"openvpn@server.service":
			ensure  => running,
			enable  => true,
			provider => "systemd",
			require => [ Package[openvpn] ];
	}

	# server configuration
	file { "${openvpn_conf_dir}/server.conf":
		content => template("vpn-server/openvpn/server.conf.erb"),
		owner   => root,
		group   => root,
		mode    => 0644,
		notify  => Service["openvpn@server.service"],
	}

	# simplistic auth method
	file { "${openvpn_conf_dir}/auth-user.sh":
		source => "puppet:///modules/vpn-server/openvpn/auth-user.sh",
		owner  => root,
		group  => root,
		mode   => 0755,
		notify => Service["openvpn@server.service"],
	}

	# user sample configuration and keys
	define openvpn_sample_key_file () {
		exec { "${openvpn_conf_dir}/${title}":
			command => "/bin/cp -a `rpm -ql openvpn | grep /sample-keys$`/${title} ${openvpn::openvpn_conf_dir}/${title} && chmod 400 ${openvpn::openvpn_conf_dir}/${title}",
			notify  => Service["openvpn@server.service"],
			creates => "${openvpn::openvpn_conf_dir}/${title}",
		}
	}

	# sample keys
	openvpn_sample_key_file { [
		"dh1024.pem",
		"ca.crt",
		"server.crt",
		"server.key"
	]: }
}
