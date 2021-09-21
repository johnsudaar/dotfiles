#!/bin/bash

exit 0

installFile "$PROJECT_ROOT/custom/config/dns/resolv.conf" "/etc/resolv.conf"
installStatus=$?
if [ $installStatus -eq 1 ] ; then
  info "resolv.conf have changed, setting immutable bit to this file"
  chattr +i /etc/resolv.conf
  failFast $? "Fail to update resolv.conf"
else
  failFast $installStatus "Fail to install resolvconf config"
fi

installFile "$PROJECT_ROOT/custom/config/dns/dnsmasq.conf" "/etc/dnsmasq.conf"
installStatus=$?
if [ $installStatus -eq 1 ] ; then
  info "Dnsmasq.conf has changed, reloading dnsmasq"
  systemctl restart dnsmasq.service
  failFast $? "Fail to reload dnsmasq"
else
  failFast $installStatus "Fail to install dnsmasq config"
fi
