function unzipd
    set ZIP_FILE "$argv[1]"
    set FILE_NAME "$(basename --suffix .zip $ZIP_FILE)"

    if [ "$argv[2][-1]" = "/" ]
        set OUT_DIR "$argv[2]/$FILE_NAME"
    else
        set OUT_DIR "$argv[2]"
    end

    if [ ! -d "$OUT_DIR" ]
        mkdir "$OUT_DIR"
    end

    echo $OUT_DIR $ZIP_FILE

    unzip -d "$OUT_DIR" "$ZIP_FILE"
end

complete -c unzipd -k -a "$(__fish_complete_suffix .zip)"
