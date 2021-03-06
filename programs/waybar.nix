[
  {
    layer = "top";
    position = "top";
    height = 22;
    spacing = 6;
    margin = "0";
    modules-left =  [
      "sway/workspaces"
      "sway/mode"
    ];
    modules-center = ["sway/window"];
    modules-right = [
      "memory"
      "cpu"
      "battery"
      "clock"
      "keyboard-state"
      "idle_inhibitor"
      "custom/poweroff"
    ];

    "sway/workspaces" = {
      all-outputs = false;
      disable-scroll = false;
      format = "{name}";
    };
    "sway/mode" = {
      format = "<span style=\"italic\">๏ {}</span>";
      tooltip = false;
    };
    "sway/window" = {
      format = "{}";
      max-length = 40;
      rewrite = {
        "(.*) - Mozilla Firefox" = "๐ $1";
        "(.*) - vim"= "๎ $1";
        "(.*) - zsh"= "๏  [$1]";
      };
    };
    keyboard-state = {
      capslock = true;
      format = "{icon}";
      format-icons = {
        locked = "Cap ";
        unlocked = "";
      };
    };
    idle_inhibitor = {
      format = "{icon}";
      format-icons = {
        activated = "๏ฎ";
        deactivated = "๏ฐ";
      };
    };
    battery = {
      bat = "BAT0";
      adapter = "AC0";
      format = "{icon} {capacity}%";
      format-charging = "๏ถ {capacity}%";
      format-full = "{icon} ๅทฒๅๆปก";
      format-icons = ["๏" "๏" "๏" "๏" "๏" "๏" "๏" "๏"];
      full-at = 96;
      format-discharging = "{icon} {capacity}%";
      format-alt = "{icon} {time}";
      format-time = "{H}:{M:02d}";
    };
    "custom/poweroff" = {
      format = "๏";
      on-click = "exec sh -c ~/.config/waybar/scripts/poweroff.sh";
      tooltip = false;
    };
    cpu = {
      format = "{icon} {usage}%";
      format-icons = ["โ" "โ" "โ" "โ" "โ" "โ" "โ" "โ"];
    };
    memory = {
      interval = 30;
      format = "{icon} {percentage}%";
      format-icons = ["โ" "โ" "โ" "โ" "โ" "โ" "โ" "โ"];
    };
    clock = {
      interval = 1;
      format = "๏ {:%H:%M:%S %a}";
      format-alt = "๏ณ {:%Y-%m-%d}";
      tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
    };
  }
  {
    layer = "top";
    position = "bottom";
    height = 22;
    spacing = 6;
    margin = "0";
    modules-left = ["network"];
    modules-center = [];
    modules-right = ["pulseaudio" "backlight" "tray"];
    network = {
      interface = "wlp1s0";
      interval = 2;
      # rotate = 30;
      format = "{icon} {essid} ({signalStrength}%)   ๏ข {bandwidthUpOctets} ๏ฃ {bandwidthDownOctets}";
      format-alt = "{icon} {ipaddr}   ๏ข {bandwidthUpOctets} ๏ฃ {bandwidthDownOctets}";
      format-icons = ["๏ช" "๏ช" "๏ซ" "๏ซ" "๏ซ" "๏ซ" "๏ซ"];
      tooltip-format = "{frequency}MHz - {ipaddr}\\{cidr}";
      format-disconnected = "๏ฌ Dรฉconnectรฉ";
      tooltip-format-disconnected = false;
      on-click-right = "kitty -e nmtui-connect";
    };
    tray = {
      icon-size = 14;
      show-passive-items = true;
      spacing = 2;
    };
    pulseaudio = {
      scroll-step = 1;
      format = "{icon} {volume}%";
      format-bluetooth = "๏ {volume}%";
      format-muted = "๏ฉ";
      format-icons = {
        headphones = "๏ฅ";
        handsfree = "๏";
        headset = "๏";
        phone = "๏";
        portable = "๏";
        car = "๏น";
        default = ["๏ง" "๏จ" "๏จ" "๏จ" "๏จ" "๏จ"];
      };
      on-click = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
      on-click-right = "pavucontrol";
    };
    backlight = {
      format = "{icon}{percent}%";
      smooth-scrolling-threshold = 1;
      format-icons = ["๏" "๏" "๏" "๏" "๏" "๏" "๏" "๏" "๏"];
      on-scroll-up = "light -U 2 && light -O";
      on-scroll-down = "light -A 2 && light -O";
    };
  }
]
