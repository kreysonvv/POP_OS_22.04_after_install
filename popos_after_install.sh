#!/usr/bin/env bash
sudo apt update
sudo apt full-upgrade -y
# Универсальная репа
sudo add-apt-repository universe -y
# Репа для wine
sudo mkdir -pm755 /etc/apt/keyrings
sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/kinetic/winehq-kinetic.sources
# Репа для sublime-text
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
# Репа для eve-ng
sudo add-apt-repository ppa:smartfinn/eve-ng-integration <<EOF
EOF
# Репа для flacon
sudo add-apt-repository ppa:flacon <<EOF
EOF
# Репа для yubiko
sudo add-apt-repository ppa:yubico/stable <<EOF
EOF
# Репа для HP
sudo add-apt-repository ppa:kelebek333/hplip -y
# Добавляем GPG ключ для Docker
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
# Добавлем репы для Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
# Репа для syncthing
sudo curl -o /usr/share/keyrings/syncthing-archive-keyring.gpg https://syncthing.net/release-key.gpg
echo "deb [signed-by=/usr/share/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list
# Репа для librewolf
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
# Репа и установка neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz
# Обновление из новых реп
sudo apt update
sudo apt dist-upgrade -y
# Настройка локалей
sudo dpkg-reconfigure locales
# Устанавливаем wine
sudo apt install --install-recommends winehq-stable -y
wine winecfg
# Устанавливаем софт
sudo apt install libu2f-udev libelf-dev libuv1=1.43.0-1ubuntu0.1 libnode72 iw curl wireguard zeal gimp -y
sudo apt install winbind playonlinux aptitude timeshift solaar npm swaks -y
sudo apt install gnome-tweaks gnome-shell-extension-manager mpv kdenlive -y
sudo apt install ubuntu-restricted-extras nmap wireshark putty gparted -y
sudo apt install gdebi keepassxc vlc audacity obs-studio eve-ng-integration -y
sudo apt install htop golang-go dirsearch patator wfuzz qbittorrent dconf-editor -y
sudo apt install hplip hplip-gui thunderbird code git audacious -y
sudo apt install filezilla openjdk-17-jre-headless default-jre openjdk-17-jre -y
sudo apt install steam-installer python3-pip python3-venv putty wireshark -y
sudo apt install libu2f-udev curl winbind playonlinux discord tmux aptitude -y
sudo apt install ubuntu-restricted-extras nmap bloodhound -y
sudo apt install rpi-imager mkvtoolnix mkvtoolnix-gui handbrake cmus -y
sudo apt install audacious fbreader flacon darktable winetricks sublime-text syncthing librewolf -y
sudo apt install yubikey-manager yubikey-personalization-gui libpam-yubico libpam-u2f yubikey-manager-qt yubioath-desktop -y
sudo apt install docker-ce docker-ce-cli docker-compose containerd.io docker-buildx-plugin docker-compose-plugin -y
sudo apt install libgstreamer1.0-0 gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-libav -y
# Создать конфиг для wg
sudo touch /etc/wireguard/wg0.conf
# Запуск - sudo wg-quick up wg0
# Устанавливаем репу kali
sudo sh -c "echo 'deb https://http.kali.org/kali kali-rolling main non-free contrib' > /etc/apt/sources.list.d/kali.list" -y
wget 'https://archive.kali.org/archive-key.asc'
sudo apt-key add archive-key.asc
sudo apt update
sudo sh -c "echo 'Package: *'>/etc/apt/preferences.d/kali.pref; echo 'Pin: release a=kali-rolling'>>/etc/apt/preferences.d/kali.pref; echo 'Pin-Priority: 50'>>/etc/apt/preferences.d/kali.pref" -y
# Обновляем
sudo apt update
# Устанавливаем софт из репы kali
sudo aptitude install -t kali-rolling wpscan python3-impacket yersinia scapy metasploit-framework gobuster airgeddon bettercap ettercap-graphical hostapd-wpe bully pixiewps dhcpd asleap hashcat hostapd tshark mdk4 hcxdumptool reaver john crunch beef lighttpd wpscan ffuf -y
# Конфиг для mpv плеера (для просмотра 4K HDR на обычном монике)
mkdir ~/.config/mpv
cat > ~/.config/mpv/mpv.conf <<EOF
vo=gpu
hwdec=auto
target-peak=400
target-contrast=1000
target-trc=srgb
target-prim=bt.709
tone-mapping=mobius
EOF
# Скачиваем и устанавливаем Telegram и Carbonyl
mkdir ~/Apps
cd ~/Apps
wget https://telegram.org/dl/desktop/linux
tar -xf linux
rm linux
wget wget https://github.com/fathyb/carbonyl/releases/download/v0.0.3/carbonyl.linux-amd64.zip
unzip carbonyl.linux-amd64.zip
rm carbonyl.linux-amd64.zip
cd ~/
# Устанавливаем webapp-manager
wget http://packages.linuxmint.com/pool/main/w/webapp-manager/webapp-manager_1.3.4_all.deb
sudo apt install ./webapp-manager_1.3.4_all.deb -y
rm webapp-manager_1.3.4_all.deb
# Устанавливаем VeraCrypt
wget https://launchpad.net/veracrypt/trunk/1.26.7/+download/veracrypt-1.26.7-Ubuntu-22.04-amd64.deb
sudo apt install ./veracrypt-1.26.7-Ubuntu-22.04-amd64.deb -y
rm veracrypt-1.26.7-Ubuntu-22.04-amd64.deb
# Устанавливаем Shodan и Goshod
pip3 install -U --user shodan
go install github.com/jayateertha043/goshod@latest
# Устанавливаем Bottles, Portproton и Element
flatpak install flathub com.usebottles.bottles -y
flatpak install flathub portproton -y
flatpak install flathub im.riot.Riot -y
# Скачиваем и устанавливаем Steam
wget https://cdn.cloudflare.steamstatic.com/client/installer/steam.deb
sudo apt install ./steam.deb -y
rm ./steam.deb
# Включаем wayland
sudo sed -i 's/WaylandEnable=false/WaylandEnable=true/' /etc/gdm3/custom.conf
# Включаем прозрачность дока
dconf write  /org/gnome/shell/extensions/dash-to-dock/background-opacity 0.3
# Скачиваем и устанавливаем obsidian
wget https://github.com/obsidianmd/obsidian-releases/releases/download/v1.5.12/obsidian_1.5.12_amd64.deb
sudo apt install -y ./obsidian_1.5.12_amd64.deb
rm ./obsidian_1.5.12_amd64.deb
# Скачиваем и устанавливаем VirtualBox
wget https://download.virtualbox.org/virtualbox/7.0.18/virtualbox-7.0_7.0.18-162988\~Ubuntu\~jammy_amd64.deb
sudo apt install -y ./virtualbox-7.0_7.0.18-162988\~Ubuntu\~jammy_amd64.deb
rm ./virtualbox-7.0_7.0.18-162988\~Ubuntu\~jammy_amd64.deb
sudo gpasswd -a $USER vboxusers
wget https://download.virtualbox.org/virtualbox/7.0.18/Oracle_VM_VirtualBox_Extension_Pack-7.0.18.vbox-extpack
sudo vboxmanage extpack install Oracle_VM_VirtualBox_Extension_Pack-7.0.18.vbox-extpack -y
rm Oracle_VM_VirtualBox_Extension_Pack-7.0.18.vbox-extpack
# Ещё раз обновляем, чтобы убрать ошибки установки, если они вдруг были
sudo apt update
sudo apt full-upgrade -y
# Устанавливаем драйвера для RTL8812au
mkdir -p ~/src
cd ~/src
git clone https://github.com/morrownr/8812au-20210820.git
cd ~/src/8812au-20210820
echo "n" | sudo ./install-driver.sh
cd ~
rm -rf ./src
# Устанавливаем zsh и oh-my-zsh
sudo apt install zsh -y 
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
# Изменить шелл по-умолчанию
chsh
# Ввести /bin/zsh
# Настройка подсветки
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
mv zsh-syntax-highlighting ~/.oh-my-zsh/plugins 
echo "source ~/.oh-my-zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
# Настроика автозаполнения на Zsh
git clone https://github.com/zsh-users/zsh-autosuggestions
mv zsh-autosuggestions ~/.oh-my-zsh/custom/plugins
sed -i 's/plugins=(git)/plugins=(git docker zsh-autosuggestions)/' ~/.zshrc 
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="jonathan"/' ~/.zshrc
# Добавляем neovim
export 'PATH="$PATH:/opt/nvim-linux64/bin"' >> ~/.zshrc
# Скачиваем и устанавливаем в систему шрифт для neovim, потом его нужно выбрать в терминале
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip
unzip JetBrainsMono.zip
rm JetBrainsMono.zip OFL.txt README.md
sudo mv JetB* /usr/local/share/fonts/
# Скачиваем и устанавливаем конфиг для nvim
wget https://github.com/magnus-root/nvim_config/archive/refs/heads/master.zip
unzip ./master.zip
mv nvim_config-master/* ~/.config/nvim
rm ./master.zip nvim_config-master
# Устанавливаем менеджер плагинов для tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tmp
# Скачиваем и устанвливаем конфиг для tmux
wget https://github.com/magnus-root/tmux_config/archive/refs/heads/master.zip
unzip ./master.zip
mkdir ~/.config/tmux
mv tmux_config-master/tmux.conf ~/.config/tmux/tmux.conf
rm -r tmux_config-master
rm ./master.zip
# Готово
echo "Для применения изменений перезапустите ПК"
