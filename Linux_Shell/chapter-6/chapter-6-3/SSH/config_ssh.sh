#!/bin/bash

config_file=sshd_config
PORT=12345

if grep -q "^Port" $config_file; then
    sed -i "/^Port/c Port $PORT" $config_file
else
    echo "Port $PORT" >> $config_file
fi

if grep -q "^PermitRootLogin" $config_file;then
    sed -i '/^PermitRootLogin/s/yes/no/' $config_file
else
    sed -i '$a PermitRootLogin no' $config_file
fi

if grep -q "^PasswordAuthentication" $config_file;then
    sed -i '/^PasswordAuthentication/s/yes/no/' $config_file
else
    sed -i '$a PasswordAuthentication no' $config_file
fi

if grep -q "^X11Forwarding" $config_file;then
    sed -i '/^X11Forwarding/s/yes/no/' $config_file
else
    sed -i '$a X11Forwarding no' $config_file
fi

if grep -q "^UseDNS" $config_file;then
    sed -i '/^UseDNS/s/yes/no/' $config_file
else
    sed -i '$a UseDNS no' $config_file
fi

