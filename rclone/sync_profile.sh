#!/bin/bash

if [ ! $# -eq 1 ]; then 
    echo "Usage: $0 <profile_name>"
    exit 1
fi

PROFILE_NAME="$1"
CONF_FILE="$HOME/.config/rclone/profiles/${PROFILE_NAME}.conf"

if [ ! -f "$CONF_FILE" ]; then
    echo "Error: Configuration profile '$CONF_FILE' not found."
    exit 1
fi

# ==========================================
# 1. GLOBAL BASELINE EXCLUSIONS
# ==========================================
# These apply to every sync profile automatically.
BASE_EXCLUDES=(
    "**/node_modules/**"
    "**/.elixir_ls/**"
    "**/_build/**"
    "**/target/**"       # Rust build artifacts (caught from your previous logs)
    "**/.git/**"         # Prevent massive object pushes
    "**/.cache/**"       # Generic cache directories
)

# Initialize an empty array for profile exclusions to prevent unbound variable errors
PROFILE_EXCLUDES=()

# ==========================================
# 2. LOAD PROFILE CONFIGURATION
# ==========================================
source "$CONF_FILE"

# ==========================================
# 3. CONSTRUCT THE EXECUTION ARRAY
# ==========================================
CMD=(/usr/bin/rclone bisync "$LOCAL_PATH" "$REMOTE_PATH" --syslog --verbose)

# Append global exclusions
for rule in "${BASE_EXCLUDES[@]}"; do
    CMD+=(--exclude "$rule")
done

# Append profile-specific exclusions
for rule in "${PROFILE_EXCLUDES[@]}"; do
    CMD+=(--exclude "$rule")
done

# ==========================================
# 4. EXECUTE
# ==========================================
# The "${CMD[@]}" syntax safely evaluates every array element as an exact argument, 
# completely bypassing bash word-splitting vulnerabilities.
"${CMD[@]}"
