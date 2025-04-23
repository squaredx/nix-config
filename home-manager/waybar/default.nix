{
  programs.waybar = {
    enable = true;

    settings.mainBar = {
      layer = "top";

      modules-left = [
        "custom/distro"
        "tray"
      ];

      modules-center = [ "hyprland/workspaces" ];

      modules-right = [
        "clock"
        "pulseaudio"
        "memory"
        "cpu"
        "custom/sleep"
        "custom/reboot"
        "custom/shutdown"
      ];

      style = builtins.readFile ./style.css;
  };
}