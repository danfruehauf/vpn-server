#!/bin/bash

auth_user() {
	local auth_file=$1; shift
	diff $auth_file /etc/openvpn/passwd > /dev/null
}

auth_user "$@"
