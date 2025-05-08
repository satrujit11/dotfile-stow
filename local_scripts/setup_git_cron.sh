#!/bin/bash

# -------------------------
# CONFIGURATION
# -------------------------
REPOS=(
  "$HOME/dotfile-stow"
  "$HOME/notes"
)

# Define script and log paths
SCRIPT_PATH="$HOME/.auto_git_commit_push.sh"
LOG_PATH="$HOME/git_auto.log"
CRON_SCHEDULE="15 14 * * 4"

# -------------------------
# CREATE THE MAIN SCRIPT
# -------------------------
cat << EOF > "$SCRIPT_PATH"
#!/bin/bash

# Repositories to check for changes
REPOS=(
  "$HOME/dotfile-stow"
  "$HOME/notes"
)

# Commit message
COMMIT_MSG="Auto-commit: \$(date)"

# Loop through each repo
for REPO in "\${REPOS[@]}"; do
  if [ -d "\$REPO/.git" ]; then
    cd "\$REPO" || continue
    git add -A
    if ! git diff --cached --quiet; then
      git commit -m "\$COMMIT_MSG"
      git push origin HEAD
    fi
  fi
done
EOF

# Make the script executable
chmod +x "$SCRIPT_PATH"

# -------------------------
# SET UP CRON JOB
# -------------------------

# Avoid duplicating the cron job by checking if it exists already
(crontab -l 2>/dev/null | grep -v "$SCRIPT_PATH" ; echo "$CRON_SCHEDULE /bin/bash $SCRIPT_PATH >> $LOG_PATH 2>&1") | crontab -

# -------------------------
# INFORM THE USER
# -------------------------

echo "✅ Auto-commit script installed and scheduled to run weekly."
echo "  ➤ Script path: $SCRIPT_PATH"
echo "  ➤ Log output:  $LOG_PATH"
echo "  ➤ Schedule:    $CRON_SCHEDULE"
