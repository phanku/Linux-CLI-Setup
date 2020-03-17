# CLI setup

# General Install Instructions

1) Install ZSH shell, tmux, and byobu
   a) yum install zsh tmux byobu
2) Type 'byobu-select-backend' and choose tmux.
3) Type byobu and then press F9 and set to launch automatically.
4) Install oh-my-zsh
   b) sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
5) Type chsh -s /bin/zsh
6) Copy all files from Linux-CLI-setup into your home directory.
7) Delete .viminfo if present.
8) Delete the .git folder from the home directory that was copied.
8) Exit the shell and reconnect.

# Vim Plugin Manager Setup

1) CD to your home directory: `cd ~`.
2) Fetch the Vim Plugin manager. I personally like Vim-Plug as it is generally the easiest VIM plugin manager to use. 

`curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
          https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim`

3) Run VIM.
4) Install selected plugins.

`:PlugInstall`

# Vim plugin selection.

1) Visit VimAwsome website to select the VIM plugins you would like.
2) Edit the `.vimrc` file. 
3) Follow the directions located at: https://github.com/junegunn/vim-plug 


References: 
https://github.com/junegunn/vim-plug
https://vimawesome.com/
