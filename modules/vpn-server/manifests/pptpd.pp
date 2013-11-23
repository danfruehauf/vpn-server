# == Class: vpn-server::pptpd
#
# Configures a pptpd VPN server
#
# === Parameters
#
# === Variables
#
# === Examples
#
#  class { vpn-server::pptpd: }
#
# === Authors
#
# Dan Fruehauf <malkodan@gmail.com>
#
# === Copyright
#
# Copyright 2013 Dan Fruehauf
#
class vpn-server::pptpd {
	if ! defined(Package[pptpd]) { package { pptpd: ensure => installed; } }
	service {
		pptpd:
			ensure  => running,
			enable  => true,
			require => Package[pptpd];
	}
}
