{
  services.hypridle = {
    enable = true;

    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session"; #lock before suspend
        after_sleep_cmd = "hyprctl dispatch dpms on";#to avoid having to press a key twice to turn on the display.
      };

      listener = [
        {
          timeout = 150; #2.5 mins
          on-timeout = "brightnessctl -s set 5";
          on-resume = "brightnessctl -r";
        }
        {
          timeout = 300; #5 mins
          on-timeout = "loginctl lock-session"; # lock screen when timeout has passed
        }
        {
          timeout = 330; # 5.5mins
          on-timeout = "hyprctl dispatch dpms off"; #screen off when timeout has passed
          on-resume = "hyprctl dispatch dpms on && brightnessctl -r"; #screen on when activity detected after timeout has fired
        }
        {
          timeout = 1800; #30 mins
          on-timeout = "systemctl suspend"; #suspend pc
        }
      ];
    };
  };
}