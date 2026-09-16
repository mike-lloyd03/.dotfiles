function nc
    set niri_dir "$HOME/.config/niri"
    set edit_file "$argv[1]"

    if [ "$edit_file" = "" ]
        pushd $niri_dir >/dev/null && nvim "$niri_dir/config.kdl" && popd >/dev/null
        return 0
    end

    if find "$niri_dir" -name "*.kdl" | grep -P "$niri_dir/$edit_file.kdl" >/dev/null
        pushd $niri_dir >/dev/null && nvim "$niri_dir/$edit_file.kdl" && popd >/dev/null
    else
        echo "$edit_file.kdl not found in niri config directory"
    end
end

complete -c nc -a "$(ls $niri_dir/ | string replace '.kdl' '')" -f
