#!/usr/bin/env fish

# Define log file
set LOGFILE "$HOME/.cache/lazyvim_update.log"

# Timestamp: Start
echo "[$(date)] Starting LazyVim update..." >$LOGFILE

# Check if nvim is in PATH
if not type -q nvim
    echo "Neovim not found. Exiting." >>$LOGFILE
    exit 1
end

# Run Lazy sync in headless mode
nvim --headless "+Lazy! sync" +qa >>$LOGFILE 2>&1

# Timestamp: Complete
echo "[$(date)] LazyVim update complete." >>$LOGFILE
