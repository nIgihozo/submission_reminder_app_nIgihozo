Submission Reminder App

This repository contains a simple Bash application designed to remind students about upcoming assignment deadlines. It includes scripts to set up the application
environment, run the reminder checks, and update assignment names.

Project Structure
The application's core files will be organized into a directory named submission_reminder_{your name} (where {your name} is the name you provide during setup)
image.png

How To Run the Application

Follow these steps to set up and run Submission Reminder App:

Step 1: Create the Application Environment

1. Clone the repository
git clone https://github.com/YourGithubUsername/submission_reminder_app_YourGithubUsername.git
cd submission_reminder_app_YourGithubUsername
(Replace YourGithubUsername with your actual GitHub Username)

2. Make the setup script executable
chmod +x create_environment.sh

3. Run the setup script: This will prompt you for your name and create the entire application directory structure.
./create_environment.sh
Follow the prompts in the terminal

Step 2. Test the Reminder App

Once the environment is created, you can run the application:

1. Navigate to the root directory of your newly created application:
cd submission_reminder_YourName/
(Replace YourName with the name you provided during the setup.)

2. Run the startup.sh script:
./startup.sh
This will display reminders for students who not submitted for the ASSIGNMENT currently configured in config.env.

Step 3. Use Copilot Shell Script to Update new Assignment Name

The copilot_shell_script.sh allows you to change the assignment bieng checked:

1. Navigate back to the root of your repository:
cd ..
(From submission_reminder_YourName/ back to submission_reminder_app_GithubUserNmae/)

2. Make copilot script executable
chmod +x copilot_shell_script.sh

3. Run the copilot script: This will prompt you for your name (used to find the app directory) and a new assignment name.
./copilot_shell_script.sh
After updating, you will re-run startup.sh to show reminders for the new assignment.

Task 3. Git Branching Workflow

This project was developed using a standard Git branching workflow

feature/setup branch: Used for all development work, rough drafts, and testing.
main ( or master) branch : Used for the final, polished application code.
only create_environment.sh, copilot_shell_script.sh, and README.md should be present on this branch after merging.

Learning Objectives 

This project help to 
Master Shell Scripting Basics: develop proficiency in writing and executing shell scripts to automate tasks such as directory creation, file manipulation, and application initialization.

Understand Application Directory Structures: understand the importance of organizing files into appropriate directories for better maintainability and scalability.

Develop Problem-Solving and Debugging Skills: enhance the ability to troubleshoot and debug scripts by testing their implementation and resolving errors.

Gain Experience with Version Control and Documentation: using version control systems to manage and submit work, and write clear and concise documentation 

Build a Functional Application from Scratch: learn how to integrate multiple components to create a working application and simulate a real-world development workflow.
