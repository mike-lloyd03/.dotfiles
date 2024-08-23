function zs
    set session_name "scratch-$(uname -n)"
    if zellij ls | grep $session_name &> /dev/null
        zellij attach $session_name
    else
        zellij -s $session_name
    end
end
