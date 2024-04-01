function nixconf
    set conf_dir "/etc/nixos"
    set subcommand "$argv[1]"

    if [ $subcommand = "" ]
        pushd $conf_dir >/dev/null ; sudo nvim "$conf_dir/configuration.nix" ; popd >/dev/null
    else if [ $subcommand = "rebuild" ]
        sudo nixos-rebuild switch
    else if [ $subcommand = "flake" ]
        pushd $conf_dir >/dev/null ; sudo nvim "$conf_dir/flake.nix" ; popd >/dev/null
    else if [ $subcommand = "home" ]
        pushd $conf_dir >/dev/null ; sudo nvim "$conf_dir/home.nix" ; popd >/dev/null
    end
end

complete -c nixconf -f -a "rebuild flake home"
