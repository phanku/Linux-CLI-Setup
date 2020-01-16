# CLI setup

# Instructions

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
