function hc
    set hypr_dir "$HOME/.config/hypr"
    set edit_file "$argv[1]"

    if [ "$edit_file" = "" ]
        pushd $hypr_dir >/dev/null && nvim "$hypr_dir/hyprland.conf" && popd >/dev/null
        return 0
    end

    if find "$hypr_dir/conf" -name "*.conf" | grep -P "$hypr_dir/conf/$edit_file.conf" >/dev/null
        pushd $hypr_dir >/dev/null && nvim "$hypr_dir/conf/$edit_file.conf" && popd >/dev/null
    else
        echo "$edit_file.conf not found in hypr config directory"
    end
end

complete -c hc -a "$(ls $hypr_dir/conf/ | string replace '.conf' '')" -f
