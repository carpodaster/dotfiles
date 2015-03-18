#!/usr/bin/env bash

JAILNAME=$1

if [ -z $JAILNAME ]; then
  echo "No jailname given."
  exit 1
fi

ezjail-admin delete -f $JAILNAME && \
  umount /jails/$JAILNAME && \
  zfs destroy tank/ezjail/$JAILNAME && \
  rmdir /jails/$JAILNAME
