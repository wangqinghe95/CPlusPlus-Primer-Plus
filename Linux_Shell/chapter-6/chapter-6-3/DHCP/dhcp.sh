#!/bin/bash

SUCCESS="echo -en \\033[1;32m"
FAILURE="echo -en \\033[1;31m"
WARNING="echo -en \\033[1;33m"
NORMAL="echo -en \\033[1;39m"
conf_file="/etc/dhcp/dhcpd.conf"

check_dhcp_package(){
    check_result=$(apt-cache search isc-dhcp-server | awk  'NR==1 {print $1}')
    if [[ "isc-dhcp-server" == $check_result ]];then
        $SUCCESS
        echo "The package of DHCP has existed, and can install"
        $NORMAL
    else
        $WARNING
        echo "There is no DHCP package, please apt update"
        $NORMAL
    fi
}

install_dhcp(){
    package_status=$(dpkg -l | grep isc-dhcp-server | awk '{print $1}')
    # if [ $package_status == "ii" -o $package_status == "iU" ]; then
    if [[ $package_status == "ii" || $package_status == "iU" ]]; then
        $NORMAL
        echo "The package of DHCP has been installed"
        $NORMAL
        dhcpd -v 2>&1 | grep "DHCP Server"
    else
        sudo apt-get install -y isc-dhcp-server &> /dev/null
        wait $!
        if [ $? -eq 0 ];then
            $SUCCESS
            echo "The package of DHCP has installed sucessfully"
            dhcpd -v 2&>1 | grep "DHCP Server"
            $NORMAL
        else
            $FAILURE
            echo "The package of DHCP has installed failed"
            $NORMAL
        fi
    fi    
}

uninstall_dhcp(){
    package_status=$(dpkg -l | grep isc-dhcp-server | awk '{print $1}')
    # if [ $package_status == "ii" -o $package_status == "iU" ]; then
    if [[ $package_status == "ii" || $package_status == "iU" ]]; then
        sudo apt remove -y isc-dhcp-server &> /dev/null
        if [ $? -eq 0 ];then
            $NORMAL
            echo "The package of DHCP has been uninstalled"
            $NORMAL
        fi        
    else
        $NORMAL
        echo "The package of DHCP has been uninstalled"
        $NORMAL
    fi    
}

read_configuration(){
    # read subnet
    echo -n "Please input the DHCP subnet(192.168.4.0):"
    $SUCCESS
    read subnet
    $NORMAL

    # read mask
    echo -n "Please input mask of the DHCP subnet(255.255.255.0):"
    $SUCCESS
    read netmask
    $NORMAL

    # read address pools
    echo -n "Please input address pool for client(192.168.4.1-192.168.4.10):"
    $SUCCESS
    read pools
    $NORMAL

    # read router
    echo -n "Please input default router for client:"
    $SUCCESS
    read router
    $NORMAL

    # read DNS
    echo -n "Please input DNS server for client:"
    $SUCCESS
    read dns
    $NORMAL

    start_ip=$(echo $pools | cut -d- -f1) # get start ip
    end_ip=$(echo $pools | cut -d- -f2)

}

modify_conf(){
    cp $conf_file{,.bak}

    # delete additional configuration
    sed -i '/10.152.187.0/{N;d}' $conf_file
    sed -i '/10.254.239.0/,+3d' $conf_file
    sed -i '/10.254.239.32/,+4d' $conf_file

    # set DHCP subnet
    sed -i 's/10.5.0.0/$subnet/' $conf_file
    # set subnet's address
    sed -i 's/255.255.255.224/$netmask/' $conf_file
    # set address's range from address's pool
    sed -i 's/10.5.5.26/$start/' $conf_file
    sed -i 's/10.5.5.30/$end/' $conf_file
    # set DNS
    sed -i 's/ns1.internal.example.org/$dns/' $conf_file
    sed -i '/internal.example.org/d' $conf_file
    # set router
    sed -i '/routers/s/10.5.5.1/$router/' $conf_file
    sed -i '/broadcast-address/d' $conf_file
    
}

check_dhcp_package
install_dhcp
# uninstall_dhcp
read_configuration

# modify config
modify_conf

sudo systemctl restart dhcpd &>/dev/null
if [ $? -eq 0 ];then
    $SUCCESS
    echo "Config Successfully"
else
    $FAILURE
    echo "Config Failed, journalctl -xe to view log"
fi
$NORMAL