function nixconf
    set nix_dir "$HOME/.config/nixos"
    set edit_file "$argv[1]"

    if [ "$edit_file" = "" ]
        pushd $nix_dir >/dev/null && nvim "$nix_dir/configuration.nix" && popd >/dev/null
        return 0
    end

    if [ -f "$nix_dir/$edit_file.nix" ]
        pushd $nix_dir >/dev/null && nvim "$nix_dir/$edit_file.nix" && popd >/dev/null
    else
        echo "$edit_file.nix not found in nixos config directory"
        return 1
    end
end
