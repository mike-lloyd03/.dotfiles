function killit
    set app "$argv[1]"
    set arg "$argv[2]"

    if [ "$arg" = "-t" ]
        set test_mode true
    else
        set test_mode false
    end

    if [ "$test_mode" = "true" ]
        procs "$app"
    else
        procs "$app" --json | jq -r '.[].PID' | xargs kill -9
    end
end
