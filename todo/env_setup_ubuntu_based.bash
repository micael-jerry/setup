#!/bin/bash

# Google Chrome
## install
## https://doc.ubuntu-fr.org/google_chrome
sudo sh -c 'echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'
wget -O- https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo tee /etc/apt/trusted.gpg.d/linux_signing_key.pub
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 78BD65473CB3BD13
sudo apt update
## if Warning
sudo apt-key export D38B4796 | sudo gpg --dearmour -o /etc/apt/trusted.gpg.d/chrome.gpg
## install
sudo apt-get install google-chrome-stable


# Git
## install
sudo apt install git
## config
git config --global user.name "<name>"
git config --global user.email <email>
ssh-keygen -t ed25519 -C <email> 		# generate ssh key
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519


# Oh My zsh
sudo apt install zsh
## https://ohmyz.sh/#install
## ohmzsh syntax hoghlighting: https://linuxhint.com/enable-syntax-highlighting-zsh/
## ohmzsh auto-suggestions: https://linuxhint.com/use-zsh-auto-suggestions/


# Develop with C
sudo apt install build-essential
sudo apt install clang
sudo apt install valgrind


# Node JS
## install nvm
## https://github.com/nvm-sh/nvm?tab=readme-ov-file#installing-and-updating
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
## install nodejs & npm & yarn
nvm install --lts
nvm use --lts
npm i -g yarn


# Java
## install
sudo apt install openjdk-21-jdk
sudo apt install openjdk-21-jre
sudo apt install maven
## config JAVA_HOME
## in .bashrc
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
export PATH=$PATH:$JAVA_HOME/bin


# Ruby
## https://www.theodinproject.com/lessons/ruby-installing-ruby
## install dependencie
sudo apt install gcc make libssl-dev libreadline-dev zlib1g-dev libsqlite3-dev libyaml-dev
## install rbenv
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
exit
## install ruby-build
mkdir -p "$(rbenv root)"/plugins
git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
## install ruby
rbenv install 3.3.0 --verbose
rbenv global 3.3.0
## gem
gem install solargraph
gem install pry-byebug


# MongoDB
## Install
## https://linuxgenie.net/install-mongodb-ubuntu-24-04/
sudo apt install gnupg curl
curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg --dearmor
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list
sudo apt update
sudo apt install mongodb-org
sudo systemctl start mongod.service
sudo systemctl enable mongod.service

# MongoDB Compass
## Download: https://www.mongodb.com/try/download/compass
## install
sudo apt install ./file.deb

# PostgreSQL
sudo apt install postgresql
# https://www.cherryservers.com/blog/install-postgresql-ubuntu
sudo systemctl status postgresql
sudo systemctl start postgresql
sudo systemctl enable postgresql


# PgAdmin
## Install: https://www.pgadmin.org/download/pgadmin-4-apt/
curl -fsS https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo gpg --dearmor -o /usr/share/keyrings/packages-pgadmin-org.gpg
sudo sh -c 'echo "deb [signed-by=/usr/share/keyrings/packages-pgadmin-org.gpg] https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list && apt update'
sudo apt install pgadmin4-desktop


# VS Code
## https://code.visualstudio.com/docs/setup/linux
## Download
## Install
sudo apt install ./file.deb


# Install other app
sudo snap install postman
sudo snap install intellij-idea-community --classic
sudo snap install pycharm-community --classic


# install and configure docker
# https://docs.docker.com/engine/install/ubuntu/
sudo usermod -aG docker $USER
