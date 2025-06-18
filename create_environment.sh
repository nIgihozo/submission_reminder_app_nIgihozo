#!/usr/bin/env bash

# Script: create_environment.sh
# Purpose: Automates the setup of the submission_reminder_app directory structure
# populates its files, and sets correct permissions.

# --- 1.Prompt for User Name and Define App Directory ---
# The script prompts the user for their name to create a personalized app directory.
# The prompt is simplified for a cleaner output
read -p "Please enter your name: " YOUR_NAME
APP_ROOT_DIR="submission_reminder_${YOUR_NAME}"

# --- 2.Create Main App Directory ---.
if ! mkdir -p "$APP_ROOT_DIR"; then
    echo "Error: Could not create directory '$APP_ROOT_DIR'.Exiting."
    exit 1
fi

# --- 3. Create Subdirectories based on the provided structure (app, modules, assets, config) ---
mkdir -p "$APP_ROOT_DIR/app" "$APP_ROOT_DIR/modules" "$APP_ROOT_DIR/assets" "$APP_ROOT_DIR/config"
# No echo for subdirectory creation, keeping output minimal.

# --- 4. Populate files with the content ---

# 4.1. Populate config/config.env (Contains assignment details)
cat << 'EOF_CONFIG' > "$APP_ROOT_DIR/config/config.env"
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF_CONFIG
# No echo for file population

# 4.2. Populate assets/submissions.txt (Contains student submission records)
cat << 'EOF_SUBMISSIONS' > "$APP_ROOT_DIR/assets/submissions.txt"
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
Emeka, Shell Navigation, not submitted
Fatima, Git, submitted
Grace, Shell Navigation, not submitted
Hamza, Shell Basics, not submitted
Kellia, Shell Navigation, not submitted
Joyce, Git, submitted
EOF_SUBMISSIONS

# 4.3. Populate app/reminder.sh (Main script to check submissions)
# Note: Path within reminder.sh are relative to the application's root directory
# because startup.sh will change the current directory before executing it.
cat << 'EOF_REMINDER' > "$APP_ROOT_DIR/app/reminder.sh"
#!/bin/bash

# Source environment variables and helper functions
# These paths are relative to the current working directory whne reminder.sh is executed.
# Startup.sh ensures the current working directory is the application's root.
source ./config/config.env
source ./modules/functions.sh

# Path to the submissions file (relative to the current working directory)
submissions_file="./assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions "$submissions_file"
EOF_REMINDER

# 4.4 Populate modules/functions.sh (Contains the check_submissions function)
cat << 'EOF_FUNCTIONS' > "$APP_ROOT_DIR/modules/functions.sh"
#!/bin/bash


# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}
EOF_FUNCTIONS

# 4.5 Implement startup.sh (Directly in APP_ROOT_DIR; now changes to APP_ROOT_DIR for execution)
cat << 'EOF_STARTUP' > "$APP_ROOT_DIR/startup.sh"
#!/usr/binenv bash

# startup.sh: Main entry point for Submission Reminder application.
# It changes the current directory to the application's root,
# then  executing the main reminder script from the 'app/' subdirectory.

# Get the root directory of the application where startup.sh resides
APP_ROOT_DIR="$(dirname "$0")"

# Change to the application's root directory.
# This is  crucial so that reminder.sh's internal relative paths  (eg., ./confi/confing.env)
# Correctly resolve from the app's root directory.
cd "$APP_ROOT_DIR" || { echo "Error: Could not change to application root directory. Exiting."; exit 1; }

# Execute the reminder.sh script which is located in the 'app/' subdirectory.
# Now we are in APP_ROOT_DIR, the path to reminder.sh is ./app/reminder.sh
echo "Starting Submission Reminder Application..."
./app/reminder.sh
EOF_STARTUP

# --- 5. Update permissions for all .sh files to be executable ---
# Finds all .sh files within the created application directory and makes them executable.
find "$APP_ROOT_DIR" -type f -name "*.sh" -exec chmod  +x {} \;
# No echo for permission updates

# --- Final User Instructions ---
echo "--- Submission Reminder App environment setup complete! ---"
echo "To test the application, navigate to its root directory:"
echo "cd $APP_ROOT_DIR"
echo "The run: ./startup.sh"

