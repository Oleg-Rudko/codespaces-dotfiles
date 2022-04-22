#!/bin/sh
# this script will be run by codespaces
# after importing this dotfile repo into a codespace

# tmux and neovim
apt-get install -y neovim
apt-get install -y tmux

# install nvim cli for nvim +PlugInstall
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# copy from root and paste to root folder
create_symlinks() {
    # Get the directory in which this script lives.
    script_dir=$(dirname "$(readlink -f "$0")")

    # Get a list of all files in this directory that start with a dot.
    files=$(find -maxdepth 1 -type f -name ".*")

    # Create a symbolic link to each file in the home directory.
    for file in $files; do
        name=$(basename $file)
        echo "Creating symlink to $name in home directory."
        rm -rf ~/$name
        ln -s $script_dir/$name ~/$name
    done
}
create_symlinks

zshrc() {
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  git clone https://github.com/wting/autojump.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/autojump

  # install zsh
  # the yes is to get past a warning related to an existing file in /etc 
  cp /etc/zsh/zlogin /etc/zsh/zlogin.original
  yes | apt-get install zsh
  cp /etc/zsh/zlogin.original /etc/zsh/zlogin

  cp -r .zshrc ~/.zshrc
  chsh -s /bin/zsh $(whoami)
  cd /root/.oh-my-zsh/custom/plugins/autojump && ./install.py
}

cp -r .config/* ~/.config

nvim +PlugInstall +qall

packages() {
  npm install -g neovim
  gem install neovim
  pip insatll --upgrade pynvim
}

packages

zshrc

