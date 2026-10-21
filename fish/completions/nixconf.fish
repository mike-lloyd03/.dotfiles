complete -c nixconf -f -a '(path change-extension "" ~/.config/nixos/**.nix | string replace ~/.config/nixos/ "" | string match -v configuration)'
