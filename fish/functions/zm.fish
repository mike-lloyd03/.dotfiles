function zm
    set session_name "main-$(uname -n)"
    if zellij ls | grep $session_name &> /dev/null
        zellij attach $session_name
    else
        zellij -s $session_name
    end
end
