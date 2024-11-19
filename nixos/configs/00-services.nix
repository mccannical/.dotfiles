{ config, ... }:

{
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };



  # List services that you want to enable:
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Cockpit
  services.cockpit = {
    enable = true;
    port = 9090;
    settings = {
      WebService = {
        AllowUnencrypted = true;
      };
    };
  };

  services.certbot = {
  enable = true;
  agreeTerms = true;
};

services.nginx = {
  enable = true;
  virtualHosts."rowing.mccannical.com" = {
    enableACME = true;
    forceSSL = true;
    root = "/var/www/rowing";
  };
};
}
