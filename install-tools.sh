#!/bin/bash
# Test it each dependency is installed and install if it is not
# Install:
#  Dependencies:
#    python ruby glibc >=2.12 go (golang) 1.2.x
#    curl rvm/rbenv gvm
# Ubuntu:
#	sudo apt-get install curl git mercurial make binutils bison gcc build-essential
# CentOS:
#	sudo yum install curl git make bison gcc glibc-devel
#	Install Mercurial from http://pkgs.repoforge.org/mercurial/
#  nmap - package deb/rpm
#  garmr
#    instead of freddyb use ygjb or mozilla ??
#git clone https://github.com/freddyb/Garmr.git
#cd Garmr
#sudo python setup.py install
#pip install garmr
#garmr -u http://my.target.app
#  dirb
#    rpm CentOS7 at Atomic
#      http://www6.atomicorp.com/channels/atomic/centos/6/x86_64/RPMS/
#      http://www6.atomicorp.com/channels/atomic/centos/7/x86_64/RPMS/
#      Also: Nikto, OpenVAS, OSSec, 
wget http://sourceforge.net/projects/dirb/files/dirb/2.21/dirb221.tar.gz/download
./configure
make
make install
#  arachni
#    Requires glibc >=2.12
wget http://downloads.arachni-scanner.com/arachni-1.0-0.5.1-linux-x86_64.tar.gz
#  heartbleed
#    Requires Go 1.2.x
#go get github.com/FiloSottile/Heartbleed
#go install github.com/FiloSottile/Heartbleed
#  SSLyze - Python
#    https://github.com/iSECPartners/sslyze
#    https://github.com/iSECPartners/sslyze/releases
#wget https://github.com/iSECPartners/sslyze/releases/download/release-0.9/sslyze-0_9-linux64.zip
#  sqlmap - Python
#    http://sqlmap.org/
git clone https://github.com/sqlmapproject/sqlmap.git sqlmap
# vim gherkin syntax highlighting
# http://rapaul.com/2010/06/21/gherkin-highlighting-for-vim/
# cp cucumber.vim ~/.vim/syntax/
# edit .vimrc

# Other tools to add ?
#  Python: golismero (full framework w/ GUI )

#apt-get install curl nmap openssl
yum install curl curl-devel nmap openssl git make bison gcc glibc-devel mercurial

# Install Go
bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
source $HOME/.gvm/scripts/gvm
gvm install go1.3
gvm use go1.3
go get github.com/FiloSottile/Heartbleed
go install github.com/FiloSottile/Heartbleed

# Install Python
# Install python 2.7
cd /etc/pki/rpm-gpg/
wget -q http://springdale.math.ias.edu/data/puias/6/x86_64/os/RPM-GPG-KEY-puias
rpm --import RPM-GPG-KEY-puias
sudo cat > /etc/yum.repos.d/puias-computational.repo <<'REPO'
[PUIAS_6_computational]
name=PUIAS computational Base $releasever - $basearch
#mirrorlist=http://puias.math.ias.edu/data/puias/computational/$releasever/$basearch/mirrorlist
baseurl=http://puias.math.ias.edu/data/puias/computational/$releasever/$basearch
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puias
REPO
yum install python27 python27-tools
#   Install pip
#sudo yum install python-pip
# Use virtualenvwrapper
sudo pip install virtualenvwrapper
mkdir ~/.virtualpythonenvs ~/Devel
export WORKON_HOME=$HOME/.virtualpythonenvs
export PROJECT_HOME=$HOME/Devel
export VIRTUALENVWRAPPER_SCRIPT=/usr/bin/virtualenvwrapper.sh
source /usr/bin/virtualenvwrapper_lazy.sh
workon
mkvirtualenv gauntlt -p /usr/bin/python2.7
workon
# Install gramr
pip install garmr
# Install sslyze - python 2.7
# dl, pushd
wget https://github.com/iSECPartners/sslyze/releases/download/release-0.9/sslyze-0_9-linux64.zip
unzip sslyze-0_9-linux64.zip
pushd sslyze-0_9-linux64
python setup.py install

# Install Ruby gems
# Use rvm
\curl -sSL https://get.rvm.io | bash -s stable 
source ~/.rvm/scripts/rvm
#Verify
type rvm | head -n 1
rvm install 1.9.3
rvm use 1.9.3 --default

cat <<GEMS > Gemfile
source 'https://rubygems.org'

# Source - may want to use binary instead
#gem 'arachni'
gem 'thor'
gem 'gauntlt'
GEMS
bundle install

# Setup using thor (gem) and templates
# https://github.com/CabForward/gauntlt_gen

# gherkin syntax highlighting in vim for .attack files
mkdir -p ~/.vim/syntax
wget https://raw.github.com/tpope/vim-cucumber/master/syntax/cucumber.vim \
  -O ~/.vim/syntax/gherkin.vim
echo "syn on" >> ~/.vimrc
echo "au Bufread,BufNewFile *.attack set filetype=gherkin" >> ~/.vimrc
