{
  programs.waybar = {
    enable = true;

    settings.mainBar = {
      layer = "top";

      modules-left = [
        "hyprland/workspaces"
        "hyprland/mode"
      ];

      modules-center = [
        "hyprland/window"
      ];

      modules-right = [
        "idle_inhibitor"
        "pulseaudio"
        "network"
        "power-profiles-daemon"
        "cpu"
        "memory"
        "temperature"
        "backlight"
        "battery"
        "clock"
        "tray"
        "custom/power"
      ];

      "hyprland/workspaces" = {
        disable-scroll = false;
        all-outputs = true;
        on-click = "activate";
        format = "{icon}";

        format-icons = {
          default = "<span color='#f5e0dc'></span>";
          active = "<span></span>";
          urgent = "<span>󰗖</span>";
          empty = "<span color='#f5e0dc'></span>";
        };

        persistent-workspaces = {
          "1" = [ ];
          "2" = [ ];
          "3" = [ ];
          "4" = [ ];
          "5" = [ ];
        };
      };

      "idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
              activated = "";
              deactivated = "";
          };
      };

      network = {
        #"interface = "wlp2*"; // (Optional) To force the use of this interface
        format-wifi = "{essid} ({signalStrength}%) ";
        format-ethernet = "{ipaddr}/{cidr} ";
        tooltip-format = "{ifname} via {gwaddr} ";
        format-linked = "{ifname} (No IP) ";
        format-disconnected = "Disconnected ⚠";
        format-alt = "{ifname}: {ipaddr}/{cidr}";
      };

      pulseaudio = {
        # scroll-step = 1
        format = "{volume}% {icon} {format_source}";
        format-bluetooth = "{volume}% {icon} {format_source}";
        format-bluetooth-muted = " {icon} {format_source}";
        format-muted = " {format_source}";
        format-source = " {volume}% ";
        format-source-muted = "";
        format-icons = {
          headphone = "";
          hands-free = "";
          headset = "";
          phone = "";
          portable = "";
          car = "";
          default = [
            ""
            ""
            ""
          ];
        };
        on-click = "pavucontrol";
      };

      "power-profiles-daemon" = {
        format = "{icon}";
        tooltip-format = "Power profile: {profile}\nDriver: {driver}";
        tooltip = true;
        format-icons = {
          default = "";
          performance = "";
          balanced = "";
          power-saver = "";
        };
      };

      "cpu" = {
        format = "{usage}% ";
        tooltip = false;
      };

      "memory" = {
        format = "{}% ";
      };

      "temperature" = {
        critical-threshold = 80;
        format = "{temperatureC}°C {icon}";
        format-icons = [
          ""
          ""
          ""
        ];
      };

      "backlight" = {
        format= "{percent}% {icon}";
        format-icons = [
          ""
          ""
          ""
          ""
          ""
          ""
          ""
          ""
          ""
        ];
      };

      "battery" = {
        states = {
          #"good = 95,
          warning = 30;
          critical = 15;
        };
        format = "{capacity}% {icon}";
        format-full = "{capacity}% {icon}";
        format-charging = "{capacity}% 󱐋";
        format-plugged = "{capacity}% ";
        format-alt = "{time} {icon}";
        #"format-good = "", // An empty format will hide the module
        #"format-full = "",
        format-icons = [
          ""
          ""
          ""
          ""
          ""
        ];
      };

      "clock" = {
        tooltip-format ="<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        format-alt ="{:%Y-%m-%d}";
      };

      "tray" = {
        spacing = 10;
      };

      "custom/power" = {
        format = " ⏻ ";
        tooltip = false;
        on-click = "rofi -show power-menu -modi power-menu:rofi-power-menu";
      };
    };
    style = builtins.readFile ./style.css;
  };
}