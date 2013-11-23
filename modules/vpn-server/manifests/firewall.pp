# == Class: vpn-server::firewall
#
# Configures forwarding and firewall rules
#
# === Parameters
#
# === Variables
#
# === Examples
#
#  class { vpn-server::firewall: }
#
# === Authors
#
# Dan Fruehauf <malkodan@gmail.com>
#
# === Copyright
#
# Copyright 2013 Dan Fruehauf
#
class vpn-server::firewall {
	if ! defined(Package[iptables]) { package { iptables: ensure => installed; } }
	service {
		iptables:
			ensure  => running,
			enable  => true,
			require => Package[iptables];
	}

	file { "/etc/sysconfig/iptables":
		notify  => Service["iptables"],
		content => template("vpn-server/firewall/iptables.erb"),
		owner   => root,
		group   => root,
		mode    => 644,
	}
}
