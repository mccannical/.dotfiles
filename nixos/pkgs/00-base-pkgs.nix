{ config, ... }:

{  # Install firefox.
  programs.firefox.enable = true;


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    cockpit
    vscodium
    lsd
    stow
    certbot
    fzf
    jq
  ];
 }
