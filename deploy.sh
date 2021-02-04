#!/bin/sh

# This creates a git submodule. Now when you run the hugo command to build your site to public,
# the created public directory will have a different remote origin (i.e. hosted GitHub repository).

# git submodule add -b main https://github.com/<USERNAME>/<USERNAME>.github.io.git public

# If a command fails then the deploy stops
set -e

printf "\033[0;32mDeploying updates to GitHub...\033[0m\n"

# Build the project.
hugo # if using a theme, replace with `hugo -t <YOURTHEME>`

# Go To Public folder
cd public

# Add changes to git.
git add .

# Commit changes.
msg="rebuilding site $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin main