# bash/zsh git prompt support

parse_git_branch() {
  LANG=C git rev-parse --symbolic-full-name --abbrev-ref HEAD 2>/dev/null | awk '{print " ("$1")" }'
}

parse_git_clean() {
    STATE=$(LANG='C' git status --short 2>/dev/null | grep "^.[MAD\\?]" | wc -l)
    if [ $STATE != 0 ]; then
        echo "$2"
    else
        echo "$1"
    fi
}
