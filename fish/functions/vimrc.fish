function vimrc
    set nvim_dir "$HOME/.config/nvim"
    set edit_file "$argv[1]"

    if [ "$edit_file" = "" ]
        pushd $nvim_dir >/dev/null && nvim "$nvim_dir/init.lua" && popd >/dev/null
        return 0
    end

    if find "$nvim_dir/lua" -name "*.lua" | grep -P "$nvim_dir/lua/$edit_file.lua" >/dev/null
        pushd $nvim_dir >/dev/null && nvim "$nvim_dir/lua/$edit_file.lua" && popd >/dev/null
    else
        echo "$edit_file.lua not found in nvim config directory"
    end
end

complete -c vimrc -a "$(ls $nvim_dir/lua/ | string replace '.lua' '')" -f
