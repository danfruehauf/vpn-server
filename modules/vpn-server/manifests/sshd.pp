# == Class: vpn-server::sshd
#
# Configures a sshd VPN server
#
# === Parameters
#
# === Variables
#
# === Examples
#
#  class { vpn-server::sshd: }
#
# === Authors
#
# Dan Fruehauf <malkodan@gmail.com>
#
# === Copyright
#
# Copyright 2013 Dan Fruehauf
#
class vpn-server::sshd {
	if ! defined(Package[openssh-server]) { package { openssh-server: ensure => installed; } }
	service {
		sshd:
			ensure  => running,
			enable  => true,
			require => Package[openssh-server];
	}

	# sshd configuration template
	$sshd_config = "/etc/ssh/sshd_config"
	file { $sshd_config:
		notify   => Service[sshd],
		content  => template("vpn-server/ssh/sshd_config.erb"),
		owner    => root,
		group    => root,
		mode     => 644,
	}
}
