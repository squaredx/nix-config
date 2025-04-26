{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  #Enable Gnome and GDM
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  environment.gnome.excludePackages = with pkgs; [
    gnome-tour # GNOME Shell detects the .desktop file on first log-in.
    gnome-user-docs
    yelp
  ];

  environment.systemPackages = with pkgs.gnomeExtensions; [
    blur-my-shell
  ];
}