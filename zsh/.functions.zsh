#!/bin/zsh

# Update stevedore
function update_stevedore() {
  if [ ! -d ~/stevedore ]; then
    git clone git@gitlab.internal.dtexgov.com:xOPs/tools/stevedore.git ~/stevedore
  fi
  cd ~/stevedore
  git pull
  cd -
}

# authentication to GAR
function authHelm() {
  region=us-docker.pkg.dev
  echo -n " |   Authenticating to GAR [$region]: "
  gcloud auth print-access-token | podman login -u oauth2accesstoken --password-stdin "${region}"
}

function gci() {
  git add .
  git commit -m  'testing ci'
  git push
  sleep 1
  glab ci view``
}

function clone_all_repos() {
  cd ~/src/fedramp/
  glab repo clone -g dig -a=false -p --paginate
  glab repo clone -g dtexgov -a=false -p --paginate
  cd -
}

function fetch_all_repos() {
  cd ~/src/fedramp/

  ls | xargs -I{} git -C {} fetch origin
}

function git_traverse_and_update() {
    # Check if a directory is provided
    if [ -z "$1" ]; then
        echo "Usage: git_traverse_and_update <directory>"
        return 1
    fi

    # Traverse the given directory
    for dir in "$1"/*; do
        # Check if it's a directory
        if [ -d "$dir" ]; then
            cd "$dir" || continue

            # Check if it's a git repository
            if [ -d ".git" ]; then
                echo "Updating repository in $dir"

                # Fetch from origin
                git fetch origin

                # Get the current branch
                current_branch=$(git branch --show-current)

                # Pull from the current branch
                git pull origin "$current_branch"
            else
                echo "$dir is not a Git repository"
            fi

            # Return to the original directory
            cd - > /dev/null
        fi
    done
}

function update_fedramp_repos() {
    # Directory to traverse
    base_dir=~/src/fedramp

    # Check if the base directory exists
    if [ ! -d "$base_dir" ]; then
        echo "$base_dir does not exist"
        return 1
    fi

    # Loop through every directory under ~/src/fedramp
    for dir in "$base_dir"/*; do
        if [ -d "$dir" ]; then
            echo "Processing $dir"
            # Call the git_traverse_and_update function on each subdirectory
            git_traverse_and_update "$dir"
        fi
    done
}

function gi() {
  curl -sLw "\n" https://www.toptal.com/developers/gitignore/api/$@ ;
}

function gitignore() {
  global_gitignore=~/.gitignore
  custom_patterns='
## Custom globals
**.idea/*
out/
generated/
*.cast
*-bkp
*-tmp
*out
*.monokle*
.monokle/*
'
  gi certificates,git,macos,windows,go,python,nodejs > "$global_gitignore"
  echo "$custom_patterns" >> "$global_gitignore"
}

function update_bastion() {
  bastion_path=${HOME}/.dotfiles/bin/bin/bastion
  # Update bastion script
  echo "\t[+] Updating bastion script"
  glab api '/projects/38/repository/files/bastions%2Fbastion?ref=main' | jq -r .content | base64 -d -i - > ${bastion_path}
  # Update bastion-beta script
  echo "\t[+] Updating bastion-beta script"
  glab api '/projects/38/repository/files/bastions%2Fbastion?ref=beta' | jq -r .content | base64 -d -i - > ${bastion_path}-beta
  chmod +x ${bastion_path}
  chmod +x ${bastion_path}-beta
}

function cp_bastion() {
  cd /Users/jesse.mccann/src/fedramp/xops/tools/stevedore/
  git checkout beta
  cp bastions/bastion ~/.dotfiles/bin/bin/bastion-beta
  cd -
}

function refreshProjects() {
  # if directory does not exist, create it
  if [ ! -d "${DTEX_CONFIG_PATH}" ]; then
    mkdir "${DTEX_CONFIG_PATH}"
  fi
  # if file is older than 4 hours, refresh it
  if [ ! -f "${PROJECTS_FILE}" ] || [ $(find "${PROJECTS_FILE}" -mmin +240) ]; then
    echo "\t[+] Refreshing projects list..."
    gcloud projects list --format json | jq -r '.[]|.projectId' | sort  > ${PROJECTS_FILE}
  fi
  # for each line of file ${PROJECTS_FILE} print line
  echo "\t[+] All projects in FedRAMP"
  while IFS= read -r line; do
    echo "\t  | ${line}"
  done < ${PROJECTS_FILE}

}

function tenantSelector() {
  refreshProjects
  export TENANT_NAME=$(grep tenant ${PROJECTS_FILE}| cut -d "-" -f2 | fzf)
}

function projectSelector() {
  refreshProjects
  export PROJECT_ID=$(grep -v tenant ${PROJECTS_FILE}| fzf)
}

function scanModules() {
  found=$(ggrep -n --exclude-dir="*.terraform*" -r 'source .*gitlab.internal.dtexgov.com' | tr -d '"')
    while IFS= read -r line; do
      lineno=$(echo $line | cut -d ":" -f2)
      filename=$(echo $line | cut -d ":" -f1)
      repo=$(echo $line | sed -e 's/.*git::https:\/\/gitlab.internal.dtexgov.com\///g' -e 's/\/\/modules.*//g' -e 's/\?.*//g' )
      tag=$(echo $line |  sed 's/.*ref=//')

      latest_tag=$(glab release list -p 1 -R $repo -P 1 | tail -n 2 | awk '{print $1}')

      echo "Found module in: $filename:$lineno with repo: $repo and tag: $tag | latest tag: $latest_tag"

    done <<< "$found"
    }