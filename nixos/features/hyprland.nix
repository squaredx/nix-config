{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
    # Enables Greetd with TUIGreet for login page
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --remember-session";
        user = "greeter";
      };
    };
  };
  
  # From Reddit rhead to hide errors
  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal"; # Without this errors will spam on screen
    # Without these bootlogs will spam on screen
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };

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