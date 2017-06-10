#!/bin/bash

##Update Ubuntu##
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get upgrade -y -o DPkg::options::="--force-confdef" -o DPkg::options::="--force-confold" 

##Install Requirements##
dpkg --add-architecture i386
apt-get update
apt-get -q -y -o DPkg::options::="--force-confdef" -o DPkg::options::="--force-confold" install unzip tmux lib32gcc1 libstdc++6:i386 binutils


##Add user csgoserver with no password##
adduser --disabled-password --gecos "" csgoserver

##Set password for user csgoserver##
yes gocs1337 | passwd csgoserver


##Get csgoserver installer from web and launch it##
cd /home/csgoserver
sudo -u csgoserver wget https://gameservermanagers.com/dl/csgoserver
sudo -u csgoserver chmod +x csgoserver
sudo -u csgoserver ./csgoserver auto-install

##Install metamod and sourcemod##
sudo -u csgoserver printf 'metamod' | sudo -u csgoserver ./csgoserver mods-install
sudo -u csgoserver printf 'sourcemod' | sudo -u csgoserver ./csgoserver mods-install


##Change Config##
#Hostname
sudo -u csgoserver sed -i 's/hostname "LinuxGSM"/hostname "E-Sports.lu - Match #1337"/' /home/csgoserver/serverfiles/csgo/cfg/csgo-server.cfg
#GSLT
sudo -u csgoserver sed -i 's/gslt=""/gslt="5BB4C57E5A5A45F60126EAE8D15021C1"/' /home/csgoserver/csgoserver
#Game Mode
sudo -u csgoserver sed -i 's/gamemode="0"/gamemode="1"/' /home/csgoserver/csgoserver

#Tick Rate
sudo -u csgoserver sed -i 's/tickrate="64"/tickrate="128"/' /home/csgoserver/csgoserver

#Enable HLTV for Demo Recording
sudo -u csgoserver echo "tv_enable 1" >> /home/csgoserver/serverfiles/csgo/cfg/csgo-server.cfg

##Start Server##
cd /home/csgoserver
sudo -u csgoserver ./csgoserver start