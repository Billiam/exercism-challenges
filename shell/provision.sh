#!/bin/bash
set -e

wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && dpkg -i erlang-solutions_1.0_all.deb
apt-get update
apt-get -f install
apt-get install -y build-essential git libssl-dev libreadline-dev libncurses5-dev zlib1g-dev m4 curl wx-common libwxgtk3.0-dev autoconf
apt-get install -y esl-erlang elixir
wget https://github.com/exercism/cli/releases/download/v2.2.6/exercism-linux-64bit.tgz
tar xzf exercism-linux-64bit.tgz
mkdir -p /home/vagrant/bin
mv exercism /home/vagrant/bin
chown vagrant:vagrant /home/vagrant/bin/elixir
rm exercism-linux-64bit.tgz
echo 'EXPORT PATH=$HOME/bin:$PATH' >> /home/vagrant/.bashrc