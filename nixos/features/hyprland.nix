{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # Keyring stuff (idk if this should be here)
  services.gnome.gnome-keyring.enable = true;

  security.pam.services.hyprland.enableGnomeKeyring = true;
  security.pam.services.login.enableGnomeKeyring = true;

  systemd.user.services.hyprpolkitagent = {
    enable = true;
    description = "Hyprpolkit agent";
    wantedBy = [ "default.target" ];
    serviceConfig.ExecStart = "${pkgs.hyprpolkitagent}/bin/hyprpolkitagent";
  };

  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    withUWSM = true; 
    xwayland.enable = true;
  };

  # Manage bluetooth
  services.blueman.enable = true;
  
  environment.systemPackages = with pkgs; [
    dunst #Notification daemon
    rofi-wayland # application launcher
    rofi-power-menu # control system power through rofi
    waybar # top status bar
    hyprpolkitagent # hyprland polkit
    yazi # TUI File manager
    hyprpaper # Wallpaper
    hypridle # idle handler
    hyprlock # lockscreen
    nautilus # file browser
    brightnessctl #for controlling screen brightness
  ];
}