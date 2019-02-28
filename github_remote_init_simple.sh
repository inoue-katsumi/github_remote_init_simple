#!/bin/bash
# This script assumes you are on the project directory and 
# you want to upload to github.com for the first time.
# First thing this does is to create new repository.
#
# Change the github username accordingly.
# TODO: Use ssh instead of https
#
repo_name=$(basename $PWD)
echo -e "# $repo_name\n\n$repo_name is ...\n\n## Usage:\n\n\`\`\`bash\n\n\`\`\`\n" >> README.md
shopt -s extglob
printf "## %s:\n\n\n" !(README.md) >> README.md
vi README.md

# I'm not sure double quote in JSON POST data won't cause any error.
curl -u inoue-katsumi https://api.github.com/user/repos -d \
	"{\"name\":\"$repo_name\",\"description\":\"$(printf "%s" $(sed -n '3p' README.md|sed "s/['\]//g"))\"}"
git init
git remote add origin https://inoue-katsumi@github.com/inoue-katsumi/$repo_name
git add *
git commit -m "Initial commit."
git push --set-upstream origin master

echo "I hope everything worked so far. Now, just checking dot files are excluded..."
git status
