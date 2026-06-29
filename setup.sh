#!/bin/bash

set -e

echo "=== Actualizando sistema ==="
sudo apt update && sudo apt upgrade -y

echo "=== Instalando utilidades base ==="
sudo apt install -y \
curl \
wget \
git \
ca-certificates \
gnupg \
python3-venv \
python3-pip \
htop \
btop \
nginx \
openjdk-21-jdk \
obs-studio \
gimp \
kdenlive \
shotcut

echo "=== Habilitando Nginx ==="
sudo systemctl enable nginx --now

echo "=== Instalando Docker ==="

sudo install -m 0755 -d /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update

sudo apt install -y \
docker-ce \
docker-ce-cli \
containerd.io \
docker-buildx-plugin \
docker-compose-plugin

sudo usermod -aG docker $USER

echo "=== Instalando Postman ==="
sudo snap install postman

echo "=== Instalando NVM ==="
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

export NVM_DIR="$HOME/.nvm"

if [ -s "$NVM_DIR/nvm.sh" ]; then
    . "$NVM_DIR/nvm.sh"
    nvm install --lts
    npm install -g @angular/cli
fi

echo "=== Instalando .NET ==="
sudo snap install dotnet-sdk --classic --channel=8.0/stable

echo "=== Instalando GitKraken ==="
sudo snap install gitkraken --classic

echo "=== Instalando Flutter ==="
sudo snap install flutter --classic

echo "=== Instalando IntelliJ ==="
sudo snap install intellij-idea-community --classic

echo "=== Instalando VS Code ==="
sudo snap install code --classic

echo "=== Instalando Android Studio ==="
sudo snap install android-studio --classic

echo "=== Instalando Opera ==="
sudo snap install opera

echo "=== Instalando Brave ==="

sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | \
sudo tee /etc/apt/sources.list.d/brave-browser-release.list

sudo apt update
sudo apt install -y brave-browser

echo "=== Instalando Google Chrome ==="

wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

sudo dpkg -i google-chrome-stable_current_amd64.deb || true
sudo apt install -f -y

rm -f google-chrome-stable_current_amd64.deb

echo "=== Instalando VirtualBox ==="
sudo apt install -y virtualbox virtualbox-ext-pack
sudo usermod -aG vboxusers $USER

echo "=== Instalando Fastfetch ==="
sudo apt install -y fastfetch || true

echo "=== Instalando AnyDesk ==="

wget -qO- https://keys.anydesk.com/repos/DEB-GPG-KEY | \
sudo gpg --dearmor -o /etc/apt/keyrings/anydesk.gpg

echo "deb [signed-by=/etc/apt/keyrings/anydesk.gpg] http://deb.anydesk.com/ all main" | \
sudo tee /etc/apt/sources.list.d/anydesk.list > /dev/null

sudo apt update
sudo apt install -y anydesk

echo "=== Instalando FortiClient VPN ==="

sudo apt install -y ./forticlient_vpn_*.deb

echo "=== Instalando RealVNC Viewer ==="

wget https://downloads.realvnc.com/download/file/viewer.files/VNC-Viewer-7.13.1-Linux-x64.deb

sudo apt install -y ./VNC-Viewer-7.13.1-Linux-x64.deb

rm VNC-Viewer-7.13.1-Linux-x64.deb

echo ""
echo "======================================"
echo "INSTALACIÓN COMPLETADA"
echo "======================================"
echo "Reinicia sesión para usar Docker sin sudo."
echo ""
echo "Verificación:"
echo "docker --version"
echo "node -v"
echo "npm -v"
echo "java -version"
echo "flutter doctor"
echo "fastfetch"
