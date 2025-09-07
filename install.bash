#!/bin/bash
set -e  # STOP ON ERROR

RC_CONFIG_FILE=("$HOME/.bashrc" "$HOME/.zshrc")
mkdir -p .tmp

echo "=== Mise à jour système ==="
sudo apt update
sudo apt upgrade -y
sudo snap refresh

echo "=== Installation des paquets de base ==="
sudo apt install -y build-essential wget curl gnupg

# Git Installation
echo "=== Git Installation ==="
sudo apt install -y git
read -p "Name: " NAME
read -p "Email: " EMAIL
git config --global user.name "$NAME"
git config --global user.email "$EMAIL"
ssh-keygen -t ed25519 -C "$EMAIL" -f ~/.ssh/id_ed25519 -N ""
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# Google Chrome Installation
echo "=== Google Chrome Installation ==="
wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -P ./.tmp
sudo apt install -y ./.tmp/google-chrome-stable_current_amd64.deb
rm -f ./.tmp/google-chrome-stable_current_amd64.deb

# VS Code Installation
echo "=== VS Code Installation ==="
echo "code code/add-microsoft-repo boolean true" | sudo debconf-set-selections
sudo apt update
sudo apt install code

# Oh My Zsh Installation
echo "=== Oh My Zsh Installation ==="
RUNZSH=no sh -c "$(wget -qO- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting || true
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions || true

# NVM Installation
echo "=== NVM Installation ==="
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

NVM_CONFIG='
# >>> NVM >>>
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
# <<< NVM <<<
'

for file in "${RC_CONFIG_FILE[@]}"; do
  grep -q '>>> NVM >>>' "$file" || echo "$NVM_CONFIG" >> "$file"
done

# Load NVM into the current shell
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install --lts
nvm use --lts

# Java Installation
echo "=== Java Installation ==="
sudo apt install -y openjdk-21-jdk openjdk-21-jre maven

JAVA_HOME_CONFIG='
# >>> JAVA_HOME
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
export PATH=$PATH:$JAVA_HOME/bin
# <<< JAVA_HOME
'

for file in "${RC_CONFIG_FILE[@]}"; do
  grep -q '>>> JAVA_HOME' "$file" || echo "$JAVA_HOME_CONFIG" >> "$file"
done

# C environment Installation
echo "=== C/C++ Toolchain Installation ==="
sudo apt install -y gcc make clang valgrind
