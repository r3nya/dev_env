#!/usr/bin/env bash

# Add repositories
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10

if [ ! -f "/etc/apt/sources.list.d/mongodb-org-3.0.list" ]; then
    echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.0.list
fi

if [ -f "/etc/apt/sources.list.d/nginx-stable-trusty.list" ]; then
    add-apt-repository ppa:nginx/stable
fi

if [ -f "/etc/apt/sources.list.d/git-core-ppa-trusty.list" ]; then
    add-apt-repository ppa:git-core/ppa
fi

if [ ! -f "/etc/apt/sources.list.d/nodesource.list" ]; then
    wget -qO- https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -
    echo "deb https://deb.nodesource.com/node_0.12 `lsb_release -sc` main" > /etc/apt/sources.list.d/nodesource.list
    echo "deb-src https://deb.nodesource.com/node_0.12 `lsb_release -sc` main" >> /etc/apt/sources.list.d/nodesource.list
fi

apt-get update

# Install packages
apt-get install -y htop mongodb-org vim nginx git curl zsh build-essential libssl-dev nodejs

locale-gen ru_RU.UTF-8

# Change default shell
chsh -s /bin/zsh vagrant

# Install oh-my-zsh & create dotfile
if [ ! -d "~vagrant/.oh-my-zsh"]; then
    su - vagrant -c "git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh"
fi

if [ ! -f "~vagrant/.zshrc" ]; then
    su - vagrant -c "cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc"
fi

# npm
npm i -g npm@latest
npm i -g bower npm-check-updates bower-update nodemon