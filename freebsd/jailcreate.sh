#!/usr/bin/env bash

EZJAIL_CONFIG=/usr/local/etc/ezjail.conf
JAILNAME=$1

if [ -z $JAILNAME ]; then
  echo "No jailname given."
  exit 1
fi

ezjail-admin create -s 2GB -c zfs $JAILNAME 're0|2a01:4f8:d16:330c::4'
ezjail-admin start $JAILNAME

. $EZJAIL_CONFIG

JAILPATH=$ezjail_jaildir/$JAILNAME
# JAILID=$(ezjail-admin list|grep ' rubytest ' |awk '{print $2}')

# NAMESERVERS
cat > $JAILPATH/etc/resolv.conf << EOF
# Hetzner's IPv6 nameservers
nameserver 2a01:4f8:0:a0a1::add:1010
nameserver 2a01:4f8:0:a102::add:9999
nameserver 2a01:4f8:0:a111::add:9898
EOF

jexec $JAILNAME pkg install --yes puppet git vim-lite curl nginx bash sudo

# This is needed by bash
# FIXME: needs sysctl tweaking in host?
#jexec $JAILNAME mount -t fdescfs fdesc /dev/fd
#jexec $JAILNAME "echo fdesc	/dev/fd		fdescfs		rw	0	0 >> /etc/fstab"

jexec $JAILNAME sh -c "echo $JAILNAME:: | adduser -s bash -M 700 -q -f -"

# TODO
# sudo $JAILNAME (curl -sSL https://get.rvm.io | bash -s stable)
