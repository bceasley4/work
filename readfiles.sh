#!/bin/bash

# Specify the two branches for comparison
branch1="branch1"

# Perform a git checkout of branch1
git checkout $branch1

# Get the merge base commit hash
merge_base=$(git merge-base origin/master $branch)

# Perform the git diff and store the different files into a variable
changed_files=$(git diff --name-only $merge_base $branch)

# Initialize arrays to store the lines and file names
lines_branch1=()
file_names_branch1=()

# Iterate over each changed file
for file in $changed_files; do
  # Read the lines of the file into a temporary array
  mapfile -t lines < $file

  # Add the lines to the list and file names
  lines_branch1+=("${lines[@]}")
  file_names_branch1+=("$file")
done

# Perform a git checkout of branch2
git checkout $branch2

# Initialize arrays to store the lines and file names
lines_branch2=()
file_names_branch2=()

# Iterate over each changed file
for file in $changed_files; do
  # Read the lines of the file into a temporary array
  mapfile -t lines < $file

  # Add the lines to the list and file names
  lines_branch2+=("${lines[@]}")
  file_names_branch2+=("$file")
done

# Pass the lists and file names to a Python file
python3 main.py "${lines_branch1[@]}" "${lines_branch2[@]}" "${file_names_branch1[@]}" "${file_names_branch2[@]}"

