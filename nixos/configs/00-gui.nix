{ config, ... }:

{
  # desktop env
  services.xserver.desktopManager.xfce.enable = true;
  services.displayManager.defaultSession = "xfce";

  # xrdp
  services.xrdp.enable = true;
  services.xrdp.defaultWindowManager = "xgce";
  services.xrdp.openFirewall = true;

}
