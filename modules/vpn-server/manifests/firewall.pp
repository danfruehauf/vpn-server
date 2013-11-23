# == Class: vpn-server::xl2tpd
#
# Configures forwarding and firewall rules
#
# === Parameters
#
# === Variables
#
# === Examples
#
#  class { vpn-server::xl2tpd: }
#
# === Authors
#
# Dan Fruehauf <malkodan@gmail.com>
#
# === Copyright
#
# Copyright 2013 Dan Fruehauf
#
class vpn-server::xl2tpd {
	if ! defined(Package[xl2tpd]) { package { xl2tpd: ensure => installed; } }
	service {
		xl2tpd:
			ensure  => running,
			enable  => true,
			require => Package[xl2tpd];
	}
}
