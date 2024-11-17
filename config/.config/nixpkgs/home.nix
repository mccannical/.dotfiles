{ pkgs, ...}: {
  programs.bash = {
    enable = false;
    bashrcExtra = ''
      . ~/oldbashrc
    '';
  };

  programs.zsh = {
  enable = true;
  enableCompletion = true;
  autosuggestion.enable = true;
  syntaxHighlighting.enable = true;

  shellAliases = {
   # zsh reload
zconf = "pycharm ~/.zshrc"
rz = "exec zsh"
# bastion/helper script
eb = "pycharm ~/src/fedramp/xops/tools/stevedore"

# dotfiles
de = "pycharm ~/.dotfiles"
dotfiles = "pycharm ~/.dotfiles"

# Kubernetes
k = kubectl

#LSD
ls = "lsd "
l = "lsd --almost-all --long "
llm = "lsd --timesort --long "
lS = "lsd --oneline --classic "
lt = "lsd --tree --depth = 4 -lha "
lf = "lsd --directory-only (.*|*)(^/) "

# stop rm and move to trash
## https://github.com/sindresorhus/trash-cli
## npm install --global trash-cli
rm = trash

# podman/docker
# Not a trailing space in value causes the next word to be checked for substitution when the is expanded.
docker = "podman "
build = "build --arch = linuxamd64"
run = "run --arch = linux/amd64"

# tailscale
tailscale = "/Applications/Tailscale.app/Contents/MacOS/Tailscale"

# git
gc = "git commit -m "
gst = "git status"
ga = "git add"
gco = "git checkout"
# helm
hls = "helm list -A"

# zoxide
cd = "z"

# tofu
tsl = "tofu state list "
ts = "tofu state show "
tv = "tofu validate "
tf = "tofu fmt "
to = "tofu output "

# glab
gl = "glab stacks list "
glnew = "glab stacks create "
glsave = "glab stacks save "
glsync = "glab stacks sync "

# anisble
av = "ansible-vault view "

  };
  history = {
    size = 10000;
    path = "${config.xdg.dataHome}/zsh/history";
  };   

}
