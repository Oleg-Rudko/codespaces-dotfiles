#!/bin/bash
# this script will be run by codespaces
# after importing this dotfile repo into a codespace



clone_and_install() {
  sudo apt update
  # tmux and neovim
  sudo apt-get install tmux
  sudo apt-get install neovim

  # install nvim cli for nvim +PlugInstall
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

  npm install -g neovim
  gem install neovim
  pip install --upgrade pynvim

  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  git clone https://github.com/wting/autojump.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/autojump
}

copy_and_paste() {
  cp -r .zshrc ~/.zshrc
  cp -r .tmux.conf ~/.tmux.conf
  cp -r .tmux.conf.local ~/.tmux.conf.local
  cp -r .config/nvim ~/.config

  sudo chsh -s /bin/zsh $(whoami)
  cd $HOME/.oh-my-zsh/custom/plugins/autojump && ./install.py

  nvim +PlugInstall +qall
}

# # copy from root and paste to root folder
# create_symlinks() {
#     # Get the directory in which this script lives.
#     script_dir=$(dirname "$(readlink -f "$0")")
#
#     # Get a list of all files in this directory that start with a dot.
#     files=$(find -maxdepth 1 -type f -name ".*")
#
#     # Create a symbolic link to each file in the home directory.
#     for file in $files; do
#         name=$(basename $file)
#         echo "Creating symlink to $name in home directory."
#         rm -rf ~/$name
#         ln -s $script_dir/$name ~/$name
#     done
# }
# create_symlinks


clone_and_install
copy_and_paste
