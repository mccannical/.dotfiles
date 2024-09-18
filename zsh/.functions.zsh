# Update stevedore
function update_stevedore() {
  if [ ! -d ~/stevedore ]; then
    git clone git@gitlab.internal.dtexgov.com:xOPs/tools/stevedore.git ~/stevedore
  fi
  cd ~/stevedore
  git pull
  cd -
}

# update DAS repos

# update xops repos

# authentication to GAR
function garAuth() {
  region=us-docker.pkg.dev
  echo -n " |   Authenticating to GAR [$region]: "
  gcloud auth print-access-token | podman login -u oauth2accesstoken --password-stdin "${region}"
}

