# bash/zsh svn prompt support
#
# Setup instructions
#
# https://github.com/mcandre/svn-prompt

parse_svn_branch() {
  parse_svn_url | sed -e 's#^'"$(parse_svn_repository_root)"'##g' | egrep -o '(tags|branches)/[^/]+|trunk' | egrep -o '[^/]+$' | awk '{print " ("$1")" }'
}
parse_svn_url() {
  svn info 2>/dev/null | sed -ne 's#^URL: ##p'
}
parse_svn_repository_root() {
  svn info 2>/dev/null | sed -ne 's#^Repository Root: ##p'
}

parse_svn_clean() {
    STATE=$(LANG='C' svn status -q 2>/dev/null | grep "^[MAD\\?]" | wc -l)
    if [ $STATE != 0 ]; then
        echo "$2"
    else
        echo "$1"
    fi
}

___svn_ps1() {
    if [ $(parse_svn_clean 0 1) = 0 ]; then
        state_color="\033[01;32m"
    else
        state_color="\033[01;31m"
    fi

   echo -e $state_color$(parse_svn_branch " %s")
   unset state_color
}
