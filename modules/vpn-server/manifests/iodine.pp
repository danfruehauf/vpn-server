# == Class: vpn-server::iodine
#
# Configures an iodine VPN server
#
# === Parameters
#
# === Variables
#
# === Examples
#
#  class { vpn-server::iodine: }
#
# === Authors
#
# Dan Fruehauf <malkodan@gmail.com>
#
# === Copyright
#
# Copyright 2013 Dan Fruehauf
#
class vpn-server::iodine {
	if ! defined(Package[iodine-server]) { package {iodine-server: ensure => installed; } }
}
