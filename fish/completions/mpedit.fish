function __mpedit_groups
    set -l dir ~/.config/metapac
    set -l active (tomlq -r --arg host (hostname) '
        if .hostname_groups_enabled then .hostname_groups[$host] else .enabled_groups end // [] | .[]
    ' $dir/config.toml 2>/dev/null)

    set -l inactive
    printf '%s\t%s\n' config config
    for group in (path basename -E $dir/groups/*.toml)
        if contains -- $group $active
            printf '%s\t%s\n' $group active
        else
            set -a inactive $group
        end
    end
    printf '%s\tinactive\n' $inactive
end

complete -c mpedit -f
complete -c mpedit -k -a '(__mpedit_groups)'
