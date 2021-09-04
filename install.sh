#!/bin/sh

set -e

# install apt-fast
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A2166B8DE8BDC3367D1901C11EE2FF37CA8DA16B
sudo apt update
sudo apt install apt-fast
pip3 install --upgrade pip

# settings
sudo apt-fast update && sudo apt-fast upgrade
timedatectl set-local-rtc true
gsettings set org.gnome.desktop.interface clock-show-seconds true
gsettings set org.gnome.desktop.interface clock-show-weekday true

# japanese
sudo apt-fast install ibus-mozc
export LANG=ja_JP.UTF-8
update-locale LANG=ja_JP.UTF-8

# laptop only
# figure show batterymy dotfiles(f
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
sudo apt-fast install sagemath mosh haskell-stack ripgrep exa bat hexyl fd-find mosh silversearcher-ag jq httpie libssl-dev pkg-config libxml2-dev
wget https://github.com/sharkdp/hyperfine/releases/download/v1.11.0/hyperfine_1.11.0_amd64.deb
sudo dpkg -i hyperfine_1.11.0_amd64.deb

stack upgrade --binary-only
stack setup

# install R
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
sudo add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"
sudo apt-fast install --no-install-recommends r-base # or sudo apt install r-base

# R Studio
# https://www.rstudio.com/products/rstudio/download/#download
# sudo dpkg -i rstudio-nuber-ditribution.deb

# Spacevim
curl -sLf https://spacevim.org/install.sh | bash -s -h

# Gitkraken
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
# gitからnerd-fontsをクローン
git clone --branch=master --depth 1 https://github.com/ryanoasis/nerd-fonts.git
cd nerd-fonts

# 好きなフォントをインストール
./install.sh #好きなフォントを指定

# 不要になったファイルを削除
cd ..
rm -rf nerd-fonts

# fish libraries
sudo apt-fast install fzf fzy peco
cargo install skim
sudo pip install percol
go get github.com/x-motemen/ghq

fisher install jethrokuan/fzf
fisher install jethrokuan/z
fisher install decors/fish-ghq

# rust libraries
cargo install procs tokei du-dust broot sd choose lsd dog xsv bandwhich xh bingrep desed topgrade ag cargo-update
cargo install --locked csview pueue
cargo install drill
drill --benchmark benchmark.yml --stats

pip3 install tldr py-spy
go get -u github.com/cheat/cheat/cmd/cheat
# mcfly
curl -LSfs https://raw.githubusercontent.com/cantino/mcfly/master/ci/install.sh | sudo sh -s -- --git cantino/mcfly
# gping
echo "deb http://packages.azlux.fr/debian/ buster main" | sudo tee /etc/apt/sources.list.d/azlux.list
wget -qO - https://azlux.fr/repo.gpg.key | sudo apt-key add -
sudo apt update
sudo apt install gping

# SNS
sudo snap install slack --classic

# install Virtualization tools
sudo apt-fast install -y qemu qemu-kvm libvirt-daemon libvirt-clients bridge-utils virt-manager

# container
sudo apt-fast -y install podman

# git tools
sudo apt-fast install hub

# tmux
pip3 install powerline-status psutil glances
ghq get powerline/fonts
go install github.com/jesseduffield/lazygit

# Vim
pip install --user python-language-server
sudo apt install clangd-11 npm
go install github.com/jstemmer/gotags@latest
go install github.com/jstemmer/gotpls@latest
