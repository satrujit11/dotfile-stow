! /bin/zsh

openproject() {
  project=$(find ~/dotfiles ~/dev/lucify ~/dev/personal ~/dev/wybble ~/dev  -mindepth 1 -maxdepth 1 -type d -o -type d | grep -E '/(dev|dotfile)' | fzf)
  project_name=$(echo "$project" | sed 's/\./_/g')

  if [ -n "$project_name " ]; then
    if tmux has-session -t "=$project_name" 2>/dev/null; then
      # If the session already exists, attach to it
      tmux switch-client -t "$project_name"
    else
      # If the session doesn't exist, create a new Tmux session
      tmux new-session -c "$project_name" -s "$project_name" -d 
      # tmux neww -c "$project_name" -n nvim -t "$project_name" -d "nvim ."
      tmux neww -c "$project_name" -n nvim -t "$project_name" -d "zsh -c 'nvim .; exec zsh'"
      tmux switch-client -t "$project_name"
    fi
  fi
}

openproject

