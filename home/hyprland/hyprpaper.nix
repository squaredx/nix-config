{ config, lib, pkgs, ... }:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "~/Pictures/Wallpapers/banff.jpeg"
      ];
      wallpaper = [
        ",~/Pictures/Wallpapers/banff.jpeg"
      ];
    };
  };
}