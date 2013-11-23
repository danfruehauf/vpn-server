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
	if ! defined(Package[iptables])          { package { iptables:         ensure => installed; } }
	if ! defined(Package[iptables-utils])    { package { iptables-utils:   ensure => installed; } }
	if ! defined(Package[iptables-services]) { package { iptables-service: ensure => installed; } }
	service {
		iptables:
			ensure  => running,
			enable  => true,
			start   => "/usr/bin/systemctl restart iptables",
			require => [ Package[iptables], Package[iptables-services], Package[iptables-utils] ];
	}

	file { "/etc/sysconfig/iptables":
		notify  => Service["iptables"],
		content => template("vpn-server/firewall/iptables.erb"),
		owner   => root,
		group   => root,
		mode    => 644,
	}

	$ipv4_forward_sysctl = "/etc/sysctl.d/ipv4_forward"
	file { $ipv4_forward_sysctl:
		content => "net.ipv4.ip_forward = 1",
		owner   => root,
		group   => root,
		mode    => 644,
	}

	exec { "/usr/sbin/sysctl -p ${ipv4_forward_sysctl}":
		provider => shell,
		onlyif   => "[ `/usr/sbin/sysctl -n net.ipv4.ip_forward` -eq 0 ]",
	}
}
