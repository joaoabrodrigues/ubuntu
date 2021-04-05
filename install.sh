#!/bin/bash

## ----------------------------------------------------------------------------------------
echo "What is your the username?"
read local_username
## ----------------------------------------------------------------------------------------

## ----------------------------------------------------------------------------------------
echo "Removing apt locks"
sudo rm /var/lib/dpkg/lock-frontend ; sudo rm /var/cache/apt/archives/lock ;
## ----------------------------------------------------------------------------------------

## ----------------------------------------------------------------------------------------
echo "Updating repo"
sudo apt update
## ----------------------------------------------------------------------------------------

## ----------------------------------------------------------------------------------------
echo "Installing python3 python3-pip git curl vim zsh copyq htop tilix openjdk-8-jdk"
sudo apt install python3 python3-pip git curl vim zsh copyq htop tilix openjdk-8-jdk -y
## ----------------------------------------------------------------------------------------

echo "Configuring git"

## ----------------------------------------------------------------------------------------
echo "What name do you want to use in GIT user.name?"
read git_config_user_name
git config --global user.name "$git_config_user_name" 
## ----------------------------------------------------------------------------------------

## ----------------------------------------------------------------------------------------
echo "What email do you want to use in GIT user.email?"
read git_config_user_email
git config --global user.email $git_config_user_email
## ----------------------------------------------------------------------------------------

## ----------------------------------------------------------------------------------------
echo "Generating a SSH Key"
ssh-keygen -t rsa -b 4096 -C $git_config_user_email -f /home/$local_username/.ssh -q -N ""
ssh-add /home/$local_username/.ssh/id_rsa
## ----------------------------------------------------------------------------------------

## ----------------------------------------------------------------------------------------
echo "Installing docker" 
sudo apt remove docker docker.io containerd runc
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io -y
sudo usermod -aG docker $local_username
docker --version
## ----------------------------------------------------------------------------------------

## ----------------------------------------------------------------------------------------
echo "Installing docker-compose" 
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version
## ----------------------------------------------------------------------------------------

echo "Installing snap packages"

## ----------------------------------------------------------------------------------------
echo "Installing postman"
snap install postman
## ----------------------------------------------------------------------------------------

## ----------------------------------------------------------------------------------------
echo "Installing code"
sudo snap install code --classic
## ----------------------------------------------------------------------------------------

## ----------------------------------------------------------------------------------------
echo "Installing code extensions"
code --install-extension hookyqr.beautify
code --install-extension formulahendry.code-runner
code --install-extension vscjava.vscode-java-debug
code --install-extension dbaeumer.vscode-eslint
code --install-extension ms-vscode.go
code --install-extension vscjava.vscode-java-dependency
code --install-extension vscjava.vscode-java-pack
code --install-extension vscjava.vscode-java-test
code --install-extension xyz.plsql-language
code --install-extension redhat.java
code --install-extension vscjava.vscode-maven
code --install-extension ms-python.python
code --install-extension adpyke.vscode-sql-formatter
code --install-extension mauve.terraform
code --install-extension visualstudioexptteam.vscodeintellicode
code --install-extension vscode-icons-team.vscode-icons
## ----------------------------------------------------------------------------------------

## ----------------------------------------------------------------------------------------
echo "Installing intellij"
echo "Do you want to install intellij ultimate? (y/n)"
read is_intellij_ultimate
if echo "$is_intellij_ultimate" | grep -iq "^y" ;then
	sudo snap install intellij-idea-ultimate --classic --edge
else
	sudo snap install intellij-idea-community --classic --edge
fi
## ----------------------------------------------------------------------------------------

## ----------------------------------------------------------------------------------------
echo "Installing node"
sudo snap install --edge node --classic
## ----------------------------------------------------------------------------------------

## ----------------------------------------------------------------------------------------
echo "Installing spotify"
sudo snap install spotify
## ----------------------------------------------------------------------------------------

## ----------------------------------------------------------------------------------------
echo "Installing flameshot"
sudo snap install flameshot
## ----------------------------------------------------------------------------------------

## ----------------------------------------------------------------------------------------
echo "Installing slack" 
sudo snap install slack --classic
## ----------------------------------------------------------------------------------------

echo "External downloads"

## ----------------------------------------------------------------------------------------
echo "Installing google chrome"
cd /home/$local_username/Downloads/
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
## ----------------------------------------------------------------------------------------

## ----------------------------------------------------------------------------------------
echo "Installing enpass"
echo "deb https://apt.enpass.io/ stable main" > \
    /etc/apt/sources.list.d/enpass.list
wget -O - https://apt.enpass.io/keys/enpass-linux.key | apt-key add -
sudo apt update && sudo apt install enpass
## ----------------------------------------------------------------------------------------

## ----------------------------------------------------------------------------------------
echo "Installing nvm" 
sh -c "$(curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash)"

export NVM_DIR="$HOME/.nvm" && (
git clone https://github.com/creationix/nvm.git "$NVM_DIR"
cd "$NVM_DIR"
git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
) && \. "$NVM_DIR/nvm.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
## ----------------------------------------------------------------------------------------

## ----------------------------------------------------------------------------------------
echo "Installing dbeaver"
wget -c https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb
sudo dpkg -i dbeaver-ce_latest_amd64.deb
## ----------------------------------------------------------------------------------------

## ----------------------------------------------------------------------------------------
echo "Installing aws-cli v2"
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
## ----------------------------------------------------------------------------------------

## ----------------------------------------------------------------------------------------
echo "Configuring inotify max_user_watches"
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p
## ----------------------------------------------------------------------------------------

echo "Configuring oh-my-zsh"
## ----------------------------------------------------------------------------------------
echo "Downloading Powerlevel10k fonts"
cd /home/$local_username/Downloads

wget -c https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
wget -c https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
wget -c https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
wget -c https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf

sudo mkdir /home/$local_username/.local/share/fonts/
sudo cp *ttf /home/$local_username/.local/share/fonts/

fc-cache -f
## ----------------------------------------------------------------------------------------

## ----------------------------------------------------------------------------------------
echo "Installing oh-my-zsh"
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
chsh -s /bin/zsh
## ----------------------------------------------------------------------------------------

## ----------------------------------------------------------------------------------------
echo "Using Powerlevel10k zsh theme"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
## ----------------------------------------------------------------------------------------

echo "System update"

## ----------------------------------------------------------------------------------------
sudo apt update && sudo apt dist-upgrade -y && sudo apt autoclean -y && sudo apt autoremove -y
## ----------------------------------------------------------------------------------------

echo "Done!"
