#!/usr/bin/env bash

# Script: copilot_shell_script.sh
# Purpose: Updates the ASSIGNMENT variable in config/config.env and re-runs the reminder app.

echo "--- Copilot: Update Assignment Name ---"

# --- 1. Prompt for User Name and New Assignment ---
#Prompts for the environment's user name (to locate the app directory)
# and the new assignment name to be set.
read -p "Enter the name you used when creating the environment: " ENV_USER_NAME
read -p "Enter the new assignment name to update:" NEW_ASSIGNMENT_NAME

# Define critical paths based on the provided user name.
APP_ROOT_DIR="submission_reminder_${ENV_USER_NAME}"
CONFIG_FILE="$APP_ROOT_DIR/config/config.env"
STARTUP_SCRIPT="$APP_ROOT_DIR/startup.sh"

# --- 2. Validate Application Environment ---
if [[ ! -d "$APP_ROOT_DIR" ]]; then
    echo "Error: Application environment '$APP_ROOT_DIR' not found."
    echo "Please ensure you have run 'create_environment.sh' successfully first with correct name."
    exit 1
fi

if [[ ! -f "$CONFIG_FILE" ]]; then
     echo "Error: Config file '$CONFIG_FILE' not found."
     echo "Please verify the environment structure."
      exit 1
fi

# ---3. Update ASSIGNMENT in config.env using sed ---
echo "Updating ASSIGNMENT in $CONFIG_FILE..."
# Uses 'sed -i' for in-place editing.
# The 's#...#...#' command substitutes the line starting with "ASSIGNMENT="
# with the new assignment name, ensuring proper quoting.
if ! sed -i "s#^ASSIGNMENT=\"[^\"]*\"#ASSIGNMENT=\"$NEW_ASSIGNMENT_NAME\"#" "$CONFIG_FILE"; then
    echo "Error: Failed to update ASSIGNMENT in $CONFIG_FILE."
    exit 1
fi
echo "Successfully updated ASSIGNMENT to: '$NEW_ASSIGNMENT_NAME'"

# --- 4. Rerun startup.sh ---
echo "Rerunning startup.sh to check non-submission status for the new assignment..."
# Checks if startup.sh is executable and then execute it.
# startup.sh will run correctly load the updated config.env.
if [[ ! -x  "$STARTUP_SCRIPT" ]]; then
    echo "Error: startup.sh not found or not executable at '$STARTUP_SCRIPT'."
    echo "Ensure 'create_environment.sh' made all .sh files executable."
    exit 1
fi
"$STARTUP_SCRIPT"
echo "--- Copilot script finished ---"
