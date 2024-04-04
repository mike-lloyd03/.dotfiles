function h
    set cmd $argv
    if [ "$argv[1]" = "cargo" ]
        cargo help "$cmd[2..]" | $PAGER
    else if [ "$argv[1]" = "go" ]
        go help "$cmd[2..]" | $PAGER
    else if [ "$argv[1]" = "aws" ]
        $cmd[1] = "/usr/bin/aws"
        "$cmd" help | $PAGER
    else if [ "$argv[1]" = "cargo" ]
        cargo help "$cmd[2..]"
    else if [ "$argv[1]" = "npm" ]
        npm help "$cmd[2..]"
    else if man -w "$cmd" &>/dev/null
        man "$cmd"
    else if eval "$cmd --help" &>/dev/null
        eval "$cmd --help" 2>&1 | $PAGER
    else
        echo "no man page or --help option available for '$cmd'"
        return 1
    end
end

complete -c h -xa "(__fish_complete_command)"
