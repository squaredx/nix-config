{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  #Enable Gnome and GDM
  services.xserver = {
    enable = true;
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
    desktopManager.gnome = {
      enable = true;
      extraGSettingsOverridePackages = [ pkgs.mutter ];
      extraGSettingsOverrides = ''
        [org.gnome.mutter]
        experimental-features=['scale-monitor-framebuffer']
      '';
    };
  };

  environment.systemPackages = with pkgs; [
    adwaita-icon-theme
    gnome-themes-extra
    #Gnome Extensions
    gnomeExtensions.appindicator
    gnomeExtensions.blur-my-shell
  ];

  #Exlude packages
  environment.gnome.excludePackages = with pkgs; [
    #epiphany #browser
    geary #email
    gnome-tour
    gnome-user-docs 
    gnome-contacts
    gnome-maps 
    gnome-music
    gnome-weather
    yelp #tour?
  ];
}