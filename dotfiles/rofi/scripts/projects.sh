#!/bin/zsh


PROJECTS_PATHS=($HOME/go/src/github.com/Scalingo $HOME/Documents/Scalingo $GOPATH/src/github.com/johnsudaar $HOME/Documents/perso)

for project_path in $PROJECTS_PATHS ; do
  for project in $(ls $project_path); do
    if [ "$ROFI_RETV" = 1 ]; then
      if [ "$project" = "$@" ]; then
        code "$project_path/$project"
        exit 0
      fi
    else
      echo "$project"
    fi
  done
done
