#! /bin/bash
sudo apt update
sudo apt full-upgrade -y
#add universal repo
sudo add-apt-repository universe
#repo for wine
sudo mkdir -pm755 /etc/apt/keyrings
sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/kinetic/winehq-kinetic.sources
#repo for sublime-text
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
#client for eve-ng
sudo add-apt-repository ppa:smartfinn/eve-ng-integration <<EOF
EOF
#repo for yubiko
sudo add-apt-repository ppa:yubico/stable <<EOF
EOF
# Add Docker's official GPG key:
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
#repo for syncthing
sudo curl -o /usr/share/keyrings/syncthing-archive-keyring.gpg https://syncthing.net/release-key.gpg
echo "deb [signed-by=/usr/share/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list
#repo for librewolf
sudo apt install -y wget gnupg lsb-release apt-transport-https
distro=$(if echo " una vanessa focal jammy bullseye vera uma" | grep -q " $(lsb_release -sc) "; then echo $(lsb_release -sc); else echo focal; fi)
wget -O- https://deb.librewolf.net/keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/librewolf.gpg
sudo tee /etc/apt/sources.list.d/librewolf.sources << EOF > /dev/null
Types: deb
URIs: https://deb.librewolf.net
Suites: $distro
Components: main
Architectures: amd64
Signed-By: /usr/share/keyrings/librewolf.gpg
EOF
#update and upgrade with new repos
sudo apt update
sudo apt dist-upgrade -y
#install wireguard
sudo apt install wireguard -y
#Создать конфиг для wg в файле - sudo nano /etc/wireguard/wg0.conf
#Запуск - sudo wg-quick up wg0
#install wine
sudo apt install --install-recommends winehq-stable -y
wine winecfg
#install soft from repos
sudo apt install libu2f-udev curl winbind playonlinux aptitude timeshift solaar gnome-tweaks gnome-shell-extension-manager ubuntu-restricted-extras nmap wireshark putty gdebi keepassxc vlc audacity gimp obs-studio zeal eve-ng-integration -y
sudo apt install htop qbittorrent thunderbird code git audacious winetricks sublime-text syncthing librewolf darktable filezilla openjdk-17-jre-headless default-jre openjdk-17-jre steam-installer python3-pip python3-venv -y
sudo apt install yubikey-manager yubikey-personalization-gui libpam-yubico libpam-u2f yubikey-manager-qt yubioath-desktop -y
sudo apt install docker-ce docker-ce-cli docker-compose containerd.io docker-buildx-plugin docker-compose-plugin -y
sudo apt install libgstreamer1.0-0 gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-libav -y
#install kali repos
sudo sh -c "echo 'deb https://http.kali.org/kali kali-rolling main non-free contrib' > /etc/apt/sources.list.d/kali.list" -y
wget 'https://archive.kali.org/archive-key.asc'
sudo apt-key add archive-key.asc
sudo apt update
sudo sh -c "echo 'Package: *'>/etc/apt/preferences.d/kali.pref; echo 'Pin: release a=kali-rolling'>>/etc/apt/preferences.d/kali.pref; echo 'Pin-Priority: 50'>>/etc/apt/preferences.d/kali.pref" -y
#update
sudo apt update
#install kali soft
sudo aptitude install -t kali-rolling wpscan dirsearch metasploit-framework gobuster airgeddon bettercap ettercap-graphical hostapd-wpe bully pixiewps dhcpd asleap hashcat hostapd tshark mdk4 hcxdumptool reaver john crunch beef lighttpd -y
#Скачиваем и устанавливаем Telegram
mkdir ~/Apps
cd ~/Apps
wget https://telegram.org/dl/desktop/linux
tar -xf linux
rm linux 
cd ~/
#Устанавливаем webapp-manager
wget http://packages.linuxmint.com/pool/main/w/webapp-manager/webapp-manager_1.3.4_all.deb
sudo apt install ./webapp-manager_1.3.4_all.deb -y
rm webapp-manager_1.3.4_all.deb
#Устанавливаем Bottles и Portproton
flatpak install flathub com.usebottles.bottles -y
flatpak install flathub portproton -y
#Скачиваем и утсанавливаем Steam
wget https://cdn.cloudflare.steamstatic.com/client/installer/steam.deb
sudo apt install ./steam.deb -y
rm ./steam.deb
#Включаем wayland
sudo sed -i 's/WaylandEnable=false/WaylandEnable=true/' /etc/gdm3/custom.conf
#Скачиваем и устанавливаем obsidian
wget https://github.com/obsidianmd/obsidian-releases/releases/download/v1.5.12/obsidian_1.5.12_amd64.deb
sudo apt install -y ./obsidian_1.5.12_amd64.deb
rm ./obsidian_1.5.12_amd64.deb
#Устанавливаем новую версию Gnome
sudo apt install gnome-session -y
#Скачиваем и устанавливаем VirtualBox
wget https://download.virtualbox.org/virtualbox/7.0.18/virtualbox-7.0_7.0.18-162988\~Ubuntu\~jammy_amd64.deb
sudo apt install -y ./virtualbox-7.0_7.0.18-162988\~Ubuntu\~jammy_amd64.deb
rm ./virtualbox-7.0_7.0.18-162988\~Ubuntu\~jammy_amd64.deb
sudo gpasswd -a $USER vboxusers
wget https://download.virtualbox.org/virtualbox/7.0.18/Oracle_VM_VirtualBox_Extension_Pack-7.0.18.vbox-extpack
sudo vboxmanage extpack install Oracle_VM_VirtualBox_Extension_Pack-7.0.18.vbox-extpack -y
rm Oracle_VM_VirtualBox_Extension_Pack-7.0.18.vbox-extpack
#install zsh и oh-my-zsh
sudo apt install zsh -y 
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
#Изменить шелл по-умолчанию
chsh
#Ввести /bin/zsh
#Настройка подсветки
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
mv zsh-syntax-highlighting ~/.oh-my-zsh/plugins 
echo "source ~/.oh-my-zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
#Настроика автозаполнения на Zsh
git clone https://github.com/zsh-users/zsh-autosuggestions
mv zsh-autosuggestions ~/.oh-my-zsh/custom/plugins
sed -i 's/plugins=(git)/plugins=(git docker zsh-autosuggestions)/' ~/.zshrc 
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="jonathan"/' ~/.zshrc
zsh
source ~/.zshrc
