complete -c unzipd -f
complete -c unzipd -n '__fish_is_nth_token 1' -a '(__fish_complete_suffix .zip)'
complete -c unzipd -n '__fish_is_nth_token 2' -a '(__fish_complete_directories)'
