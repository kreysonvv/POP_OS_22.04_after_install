#! /bin/bash
#add universal repo
sudo add-apt-repository universe
sudo apt update
sudo apt full-upgrade -y
#add VirtualBox repo
sudo bash -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/oracle-virtualbox-2016.gpg] https://download.virtualbox.org/virtualbox/debian jammy contrib" >> /etc/apt/sources.list'
wget -O- https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo gpg --dearmor --es --output /usr/share/keyrings/oracle-virtualbox-2016.gpg
#install and enable ssh
sudo apt install openssh-server -y
sudo systemctl start sshd
#repo for wine
sudo mkdir -pm755 /etc/apt/keyrings
sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/kinetic/winehq-kinetic.sources
#client for eve-ng
sudo add-apt-repository ppa:smartfinn/eve-ng-integration
#Ключ для Sublime-text
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg > /dev/null
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
#repo for Ansible
sudo add-apt-repository --yes --update ppa:ansible/ansible
#curl and ansible
sudo apt install curl ansible libu2f-udev -y
#repo for syncthing
sudo curl -o /usr/share/keyrings/syncthing-archive-keyring.gpg https://syncthing.net/release-key.gpg
echo "deb [signed-by=/usr/share/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list
#repo for librewolf
sudo apt install -y wget gnupg lsb-release apt-transport-https ca-certificates
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
sudo apt install aptitude virtualbox-7.0 gnome-tweaks gnome-shell-extension-manager ubuntu-restricted-extras nmap wireshark putty gdebi keepassxc vlc audacity gimp obs-studio zeal eve-ng-integration -y
sudo apt install winetricks sublime-text syncthing librewolf darktable filezilla docker openjdk-17-jre-headless default-jre steam-installer python2 python3-pip python3-venv -y
#install kali repos
sudo sh -c "echo 'deb https://http.kali.org/kali kali-rolling main non-free contrib' > /etc/apt/sources.list.d/kali.list" -y
wget 'https://archive.kali.org/archive-key.asc'
sudo apt-key add archive-key.asc
sudo apt update
sudo sh -c "echo 'Package: *'>/etc/apt/preferences.d/kali.pref; echo 'Pin: release a=kali-rolling'>>/etc/apt/preferences.d/kali.pref; echo 'Pin-Priority: 50'>>/etc/apt/preferences.d/kali.pref" -y
#update
sudo apt update
#install kali soft
sudo aptitude install -t kali-rolling wpscan dirsearch gobuster airgeddon bettercap ettercap-graphical hostapd-wpe bully pixiewps dhcpd asleap hashcat hostapd tshark mdk4 hcxdumptool reaver john crunch beef lighttpd -y
#install zsh и oh-my-zsh
sudo apt install zsh -y
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
#Изменить шелл по-умолчанию
chsh
#Ввести /bin/zsh
#Настройка подсветки
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
mv zsh-syntax-highlighting ~/.oh-my-zsh/plugins
#Затем вставьте следующую строку в конец файла ~/.zshrc: source ~/.oh-my-zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#Настроика автозаполнения на Zsh
git clone https://github.com/zsh-users/zsh-autosuggestions
mv zsh-autosuggestions ~/.oh-my-zsh/custom/plugins
#Затем добавьте плагин в список плагинов в файле ~/.zshrc: plugins=(git docker gcloud terraform vagrant zsh-autosuggestions)
zsh
source ~/.zshrc
