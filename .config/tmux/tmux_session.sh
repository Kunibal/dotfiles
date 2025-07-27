#!/bin/bash

SESSION_NAME="$1"
START_DIR="$2"
NOTES_DIR="$HOME/memo/$1"

if [[ ! -d "$START_DIR" ]]; then
  mkdir -p $START_DIR
fi

if [[ ! -d "$NOTES_DIR" ]]; then
  mkdir -p $NOTES_DIR
fi

tmux has-session -t $SESSION_NAME 2>/dev/null

if [ $? != 0 ]; then
  tmux new-session -d -s "$SESSION_NAME" -c "$START_DIR" -n "editor"

  tmux send-keys -t $SESSION_NAME:editor "vim ." C-m

  tmux new-window -t $SESSION_NAME -c "$START_DIR" -n "server"

  tmux new-window -t $SESSION_NAME -c "$NOTES_DIR" -n "notes"

  tmux select-window -t $SESSION_NAME:editor
fi

if [[ -n "$TMUX" ]]; then
  tmux switch-client -t "$SESSION_NAME"
else
  tmux attach-session -t "$SESSION_NAME"
fi
