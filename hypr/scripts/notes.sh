#!/bin/bash

NOTES_DIR="$HOME/notes"
mkdir -p "$NOTES_DIR"

case $1 in
    browse) target="$NOTES_DIR" ;;
    *) target="$NOTES_DIR/$(date +%Y-%m-%d_%H%M%S).md" ;;
esac

exec terminator --working-directory "$NOTES_DIR" -x nvim "$target"
