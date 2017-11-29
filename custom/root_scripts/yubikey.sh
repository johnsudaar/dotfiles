#!/bin/bash

systemctl enable pcscd
systemctl start pcscd

installFile "$PROJECT_ROOT/custom/config/system-auth" "/etc/pam.d/system-auth"
installStatus=$?
if [ $installStatus -ne 1 ] ; then
  failFast $installStatus "Fail to install system auth config"
fi

installFile "$PROJECT_ROOT/custom/config/yubikeys" "/etc/yubikeys"
chmod 644 /etc/yubikeys
installStatus=$?
if [ $installStatus -ne 1 ] ; then
  failFast $installStatus "Fail to install yubikeys"
fi
success "Yubikey configured"
