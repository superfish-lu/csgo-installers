#!/bin/bash
##Disable IPv6 to avoid apt get stuck##
echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
echo "net.ipv6.conf.default.disable_ipv6 = 1" >> /etc/sysctl.conf
echo "net.ipv6.conf.lo.disable_ipv6 = 1" >> /etc/sysctl.conf
sudo sysctl -p

##Update Ubuntu##
#export DEBIAN_FRONTEND=noninteractive
#apt-get update
#apt-get upgrade -y -o DPkg::options::="--force-confdef" -o DPkg::options::="--force-confold" 

##Install Requirements##
dpkg --add-architecture i386
apt-get update
apt-get -q -y -o DPkg::options::="--force-confdef" -o DPkg::options::="--force-confold" install unzip tmux lib32gcc1 libstdc++6:i386 binutils aria2

##Add user csgoserver with no password##
adduser --disabled-password --gecos "" csgoserver

##Set password for user csgoserver##
yes gocs1337 | passwd csgoserver

##Preload csgo files from files.e-sports.lu for faster install
cd /home/csgoserver
sudo -i -u csgoserver aria2c http://files.e-sports.lu/serverfiles.tar.gz http://retake.e-sports.lu/serverfiles.tar.gz http://multi.e-sports.lu/serverfiles.tar.gz
sudo -i -u csgoserver tar -xzvf serverfiles.tar.gz
sudo -i -u csgoserver rm serverfiles.tar.gz

##Get csgoserver installer from web and launch it##
sudo -i -u csgoserver wget https://gameservermanagers.com/dl/csgoserver
sudo -i -u csgoserver chmod +x csgoserver
sudo -i -u csgoserver ./csgoserver auto-install

##Install metamod and sourcemod##
#sudo -i -u csgoserver printf 'metamod' | sudo -i -u csgoserver ./csgoserver mods-install
#sudo -i -u csgoserver printf 'sourcemod' | sudo -i -u csgoserver ./csgoserver mods-install


##Change Config##
#Hostname
sudo -i -u csgoserver sed -i 's/hostname "LinuxGSM"/hostname "E-Sports.lu - Match #1337"/' /home/csgoserver/serverfiles/csgo/cfg/csgo-server.cfg
#GSLT
sudo -i -u csgoserver sed -i 's/gslt=""/gslt="5BB4C57E5A5A45F60126EAE8D15021C1"/' /home/csgoserver/csgoserver
#Game Mode
sudo -i -u csgoserver sed -i 's/gamemode="0"/gamemode="1"/' /home/csgoserver/csgoserver

#Tick Rate
sudo -i -u csgoserver sed -i 's/tickrate="64"/tickrate="128"/' /home/csgoserver/csgoserver

#Enable HLTV for Demo Recording
sudo -i -u csgoserver echo "tv_enable 1" >> /home/csgoserver/serverfiles/csgo/cfg/csgo-server.cfg

#Add admins to SourceMod
#sudo -i -u csgoserver echo '"STEAM_0:0:77074401" "99:z"' >> /home/csgoserver/serverfiles/csgo/addons/sourcemod/configs/admins_simple.ini
#sudo -i -u csgoserver echo '"STEAM_0:1:18037936" "99:z"' >> /home/csgoserver/serverfiles/csgo/addons/sourcemod/configs/admins_simple.ini
#sudo -i -u csgoserver echo '"STEAM_0:1:2483865" "99:z"' >> /home/csgoserver/serverfiles/csgo/addons/sourcemod/configs/admins_simple.ini
