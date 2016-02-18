#!/bin/bash

SESSION=`basename $PWD`
tmux="tmux -2 -u -f $HOME/.tmux.conf"

# vim
$tmux -2 new-session -d -s $SESSION -n 'vim'
$tmux split-window -t 1 -h -p 25

#logs
$tmux new-window -t $SESSION -n 'logs'

# mysql
$tmux new-window -t $SESSION -n 'mysql'
$tmux split-window -h

# svn
$tmux new-window -t $SESSION -n 'svn'

# attach to session
$tmux select-window -t $SESSION:1 \; select-pane -t 1
$tmux attach-session -t $SESSION
