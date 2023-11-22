function zs
    set session_name "scratch-$(hostname)"
    if zellij ls | grep $session_name &> /dev/null
        zellij attach $session_name
    else
        zellij -s $session_name
    end
end
