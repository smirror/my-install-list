#!/bin/sh

set -e

# install apt-fast
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A2166B8DE8BDC3367D1901C11EE2FF37CA8DA16B
sudo apt update
sudo apt install apt-fast

sudo apt-fast update && sudo apt-fast upgrade
timedatectl set-local-rtc true
gsettings set org.gnome.desktop.interface clock-show-seconds true
gsettings set org.gnome.desktop.interface clock-show-weekday true

# laptop only
# figure show battery
gsettings set org.gnome.desktop.interface show-battery-percentage true

# install Docker
sudo apt-fast install -y curl apt-transport-https \
software-properties-common ca-certificates

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
echo "deb [arch=amd64] https://download.docker.com/linux/debian stretch stable" | \
sudo tee /etc/apt/sources.list.d/docker-engine.list

sudo apt-fast update -y
sudo apt-fast install -y docker-ce

# install kubernetes
sudo apt-fast update && sudo apt-fast install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt-fast update
sudo apt-fast install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

# install apt package
sudo apt-fast install sagemath mosh haskell-stack ripgrep exa bat hexyl fd-find mosh silversearcher-ag jq

stack upgrade --binary-only
stack setup

# r
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
sudo add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"
sudo apt-fast install --no-install-recommends r-base # or sudo apt install r-base



# rstudio
# https://www.rstudio.com/products/rstudio/download/#download
# sudo dpkg -i rstudio-nuber-ditribution.deb

# spacevim
curl -sLf https://spacevim.org/install.sh | bash -s -h

# gitkraken
wget https://release.gitkraken.com/linux/gitkraken-amd64.deb
sudo dpkg -i gitkraken-amd64.deb

# JetBrains softwares
sudo snap install intellij-idea-educational --classic
sudo snap install goland --classic
sudo snap install clion --classic
sudo snap install pycharm-educational --classic

# fish
echo 'deb http://download.opensuse.org/repositories/shells:/fish:/release:/3/Debian_10/ /' | sudo tee /etc/apt/sources.list.d/shells:fish:release:3.list
curl -fsSL https://download.opensuse.org/repositories/shells:fish:release:3/Debian_10/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/shells_fish_release_3.gpg > /dev/null
sudo apt update
sudo apt install fish

## fisher
fish
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher

# starship (install & update)
sh -c "$(curl -fsSL https://starship.rs/install.sh)"

# fish libraries
sudo apt-fast install fzf fzy peco
cargo install skim
sudo pip install percol
go get github.com/x-motemen/ghq

fisher install jethrokuan/fzf
fisher install jethrokuan/z
fisher install decors/fish-ghq

# cargo libraries
cargo install procs tokei du-dust broot sd choose
pip3 install tldr

# mcfly
curl -LSfs https://raw.githubusercontent.com/cantino/mcfly/master/ci/install.sh | sh -s -- --git cantino/mcfly

# SNS
sudo snap install slack --classic

# install Virtualization tools
sudo apt-fast install qemu kvm

# container
sudo apt-fast -y install podman
