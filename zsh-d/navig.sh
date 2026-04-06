# lf directory changer (lfcd)
lfcd () {
    tmp="$(mktemp -t lfcd.XXXXXX)"
    # Run lf and tell it to output the last directory to our temp file
    command lf -last-dir-path="$tmp" "$@"
    
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        # If the directory is valid and different from our current one, change to it
        if [ -d "$dir" ] && [ "$dir" != "$(pwd)" ]; then
            cd "$dir"
        fi
    fi
}

# Alias 'lf' to run our wrapper function instead of the raw binary
alias lf="lfcd"
