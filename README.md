# vpn-server

A cookbook to build a test VPN server for check_vpn:
https://github.com/danfruehauf/nagios-plugins/tree/master/check_vpn

## Features

Builds a VPN server with:
 * L2TP (xl2tpd)
 * PPTP (poptop pptpd)
 * OpenVPN
 * SSH

## Instalation

Simply check out the repository and run:
```
# ./puppet-apply.sh
```
## Limitations

### Fedora support

Tested only with Fedora 19.
