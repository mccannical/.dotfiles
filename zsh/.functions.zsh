#!/bin/zsh
DTEX_CONFIG_PATH="${HOME}/.config/dtex"
# Update stevedore
function update_bastion() {
  stevedore_id=$(glab api "/projects?search=stevedore" | jq '.[]|.id')
  glab api '/projects/'"${stevedore_id}"'/repository/files/bastions%2Fbastion?ref=main' | jq -r '.content' | base64 -d  > ~/bin/bastion
  glab api '/projects/'"${stevedore_id}"'/repository/files/bastions%2Fbastion?ref=beta' | jq -r '.content' | base64 -d  > ~/bin/bastion-beta
}

function fetch_all_repos() {
  cd ~/src/ || exit
  echo "Cloning all fedramp repos"
  glab api "/groups?top_level_only=true" | jq -r '.[].name' | \
    while IFS=$'\t' read -r group; do
      echo "Cloning all repos in [$group]"
      glab repo clone --group  "$group" --preserve-namespace --archived=false --paginate
    done
}

function toptal_gitignore() {
  curl -sLw "\n" https://www.toptal.com/developers/gitignore/api/$@ ;
}

function generate_global_gitignore() {
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
  toptal_gitignore certificates,git,macos,windows,go,python,nodejs > "$global_gitignore"
  echo "$custom_patterns" >> "$global_gitignore"
}

function refreshProjects() {
  # if directory does not exist, create it
  if [ ! -d "${DTEX_CONFIG_PATH}" ]; then
    mkdir "${DTEX_CONFIG_PATH}"
  fi
  # if file is older than 4 hours, refresh it
  if [ ! -f "${PROJECTS_FILE}" ] || [ "$(find "${PROJECTS_FILE}" -mmin +240)" ]; then
    printf "\t[+] Refreshing projects list..."
    gcloud projects list --format json | jq -r '.[]|.projectId' | sort  > "${PROJECTS_FILE}"
  fi
  # for each line of file ${PROJECTS_FILE} print line
  printf "\t[+] All projects in FedRAMP"
  while IFS= read -r line; do
    printf "\t  | %s" "${line}"
  done < ${PROJECTS_FILE}
}

function tenantSelector() {
  refreshProjects
  export TENANT_NAME=$(grep tenant "${PROJECTS_FILE}"| cut -d "-" -f2 | fzf)
}

function projectSelector() {
  refreshProjects
  export PROJECT_ID=$(grep -v tenant "${PROJECTS_FILE}"| fzf)
}

function proxy() {
  HTTPS_PROXY="socks5://localhost:8080" $@
}


# tofu
function tunl() {
  tofu force-unlock -force $1
}