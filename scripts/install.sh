sudo apt update
sudo apt upgrade -y
sudo apt autoremove -y
sudo apt install ssh -y
sudo apt install vim-gnome -y
sudo apt install shadowsocks -y
sudo apt install ctags -y
sudo apt install cmake -y
sudo apt install zsh -y
sudo apt install python3 python3-distutils -y
sudo apt install python3-pip -y
sudo apt install make -y
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
pip3 install --upgrade pip
pip3 install youtube-dl
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

