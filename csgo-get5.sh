##Install Get5##
#Base Plugin and API 
cd /home/csgoserver/serverfiles/csgo
sudo -u csgoserver wget https://github.com/splewis/get5/releases/download/0.5.2/get5_0.5.2.zip
sudo -u csgoserver unzip get5_0.5.2.zip
sudo -u csgoserver mv addons/sourcemod/plugins/disabled/get5_apistats.smx addons/sourcemod/plugins/

#SMJansson
sudo -u csgoserver wget https://github.com/thraaawn/SMJansson/raw/master/bin/smjansson.ext.so
sudo -u csgoserver mv smjansson.ext.so addons/sourcemod/extensions/

#SteamWorks
sudo -u csgoserver wget http://users.alliedmods.net/~kyles/builds/SteamWorks/SteamWorks-git121-linux.tar.gz
sudo -u csgoserver tar -xzf SteamWorks-git121-linux.tar.gz

##Re-Start Server##
cd /home/csgoserver
sudo -u csgoserver ./csgoserver stop
sudo -u csgoserver ./csgoserver start
