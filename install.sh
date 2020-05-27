#!/bin/bash

## Removendo travas eventuais do apt ##

sudo rm /var/lib/dpkg/lock-frontend ; sudo rm /var/cache/apt/archives/lock ;

## Atualizando o repositório ##

sudo apt update && 

## Instalando pacotes e programas do repositório deb do Ubuntu ##

sudo apt install python3 python-pip docker docker-compose git -y &&

## Instalando pacotes Snap ##

sudo snap install code --classic &&  
sudo snap install --edge node --classic && 
sudo snap install spotify &&

## Adicionando repositório Flathub ##

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo && 

## Instalando Apps do Flathub ##

sudo flatpak install flathub io.dbeaver.DBeaverCommunity -y &&

## Softwares que precisam de download externo ##

## Google Chrome ##

cd ~/Downloads/ && wget -c https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && sudo dpkg -i *.deb &&

## Enpass ##

echo "deb https://apt.enpass.io/ stable main" > \
    /etc/apt/sources.list.d/enpass.list &&
    
wget -O - https://apt.enpass.io/keys/enpass-linux.key | apt-key add - &&

sudo apt update && sudo apt install enpass &&





## Atualização do sistema ##

sudo apt update && sudo apt dist-upgrade -y && sudo apt autoclean -y && sudo apt autoremove -y &&

#Fim do Script ##
