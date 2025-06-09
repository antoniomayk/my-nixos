{ ... }:

let
  readAndPadFile = file: "\n${builtins.readFile file}\n";

  gruvbox_0 = "#1d2021";
  gruvbox_1 = "#cc241d";
  gruvbox_2 = "#98971a";
  gruvbox_3 = "#d79921";
  gruvbox_4 = "#458588";
  gruvbox_5 = "#b16286";
  gruvbox_6 = "#689d6a";
  gruvbox_7 = "#a89984";
  gruvbox_8 = "#928374";
  gruvbox_9 = "#fb4934";
  gruvbox_10 = "#b8bb26";
  gruvbox_11 = "#fabd2f";
  gruvbox_12 = "#83a598";
  gruvbox_13 = "#d3869b";
  gruvbox_14 = "#8ec07c";
  gruvbox_15 = "#ebdbb2";

  colors = {
    gruvbox = {
      bg = "#000000";
      fg = gruvbox_15;
      inn = gruvbox_12;
      afoc = gruvbox_10;
      ifoc = gruvbox_8;
      ufoc = gruvbox_0;
      urgt = gruvbox_9;
      warn = gruvbox_11;
      phol = "#000000";
    };
  };
  theme = {
    colors = colors.gruvbox;
    margin = 4;
    border-size = 1;
    border-radius = 8;
    font = "JetBrainsMono Nerd Font";
    font-size = "10";
  };
in
{
  home-manager.users.mayk =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        anytype
        brave
        discord
        gcolor3
        ghostty
        gimp3
        grim
        insomnia
        krita
        lazydocker
        lazygit
        neofetch
        obsidian
        pavucontrol
        pulseaudio
        swaybg
        swayidle
        swaylock
        vivaldi
        vivaldi-ffmpeg-codecs
        wl-clipboard
        wlprop
        youtube-music
      ];

      dconf.settings = {
        "org/virt-manager/virt-manager/connections" = {
          autoconnect = [ "qemu:///system" ];
          uris = [ "qemu:///system" ];
        };
        "org/cinnamon/desktop/interface" = {
          gtk-theme = "Mint-Y-Dark-Grey";
          icon-theme = "Papirus-Dark";
          cursor-theme = "Adwaita";
          font-name = "JetBrainsMono Nerd Font 10";
        };
        "org/cinnamon/theme" = {
          name = "Mint-Y-Dark-Grey";
        };
        "org/cinnamon/desktop/wm/preferences" = {
          titlebar-font = "JetBrainsMono Nerd Font 10";
          theme = "Mint-Y-Dark-Grey";
          button-layout = ":minimize,maximize,close";
        };
        "x/dm/slick-greeter" = {
          cursor-theme-name = "Adwaita";
          icon-theme-name = "Papirus-Dark";
          theme-name = "Mint-Y-Dark-Grey";
          font-name = "JetBrainsMono Nerd Font 10";
        };
        "org/gnome/desktop/interface" = {
          font-name = "JetBrainsMono Nerd Font 10";
          document-font-name = "JetBrainsMono Nerd Font 10";
          monospace-font-name = "JetBrainsMono Nerd Font 10";
        };
        "org/x/apps/portal" = {
          color-scheme = "prefer-dark";
        };
        "org/nemo/desktop" = {
          font = "JetBrainsMono Nerd Font 10";
        };
        "org/cinnamon" = {
          enabled-applets = "['panel1:left:0:menu@cinnamon.org:0', 'panel1:left:1:separator@cinnamon.org:1', 'panel1:left:4:grouped-window-list@cinnamon.org:2', 'panel1:right:4:systray@cinnamon.org:3', 'panel1:right:5:xapp-status@cinnamon.org:4', 'panel1:right:7:notifications@cinnamon.org:5', 'panel1:right:8:printers@cinnamon.org:6', 'panel1:right:9:keyboard@cinnamon.org:8', 'panel1:right:10:favorites@cinnamon.org:9', 'panel1:right:11:network@cinnamon.org:10', 'panel1:right:12:sound@cinnamon.org:11', 'panel1:right:13:power@cinnamon.org:12', 'panel1:right:15:calendar@cinnamon.org:13', 'panel1:right:16:cornerbar@cinnamon.org:14', 'panel1:left:2:workspace-switcher@cinnamon.org:15', 'panel1:right:6:separator@cinnamon.org:15', 'panel1:right:3:separator@cinnamon.org:16', 'panel1:right:14:separator@cinnamon.org:17', 'panel1:left:3:separator@cinnamon.org:18']";
          hotcorner-layout = "['expo:true:0', 'scale:true:0', 'scale:false:0', 'desktop:true:0']";
          panel-zone-symbolic-icon-sizes = "[{\"panelId\": 1, \"left\": 28, \"center\": 28, \"right\": 16}]";
          panel-zone-icon-sizes = "[{\"panelId\": 1, \"left\": 0, \"center\": 0, \"right\": 16}]";
        };
        "org/cinnamon/desktop/background" = {
          picture-uri = "file://${./config/wallpaper/16.jpeg}";
        };
        "org/cinnamon/desktop/applications/terminal" = {
          exec = "ghostty";
          exec-arg = "--working-directory";
        };
      };

      systemd.user = {
        services.gnome-dconf-apply = {
          Unit = {
            Description = "Disable WM button-layout";
            PartOf = [ "graphical-session.target" ];
            After = [ "graphical-session.target" ];
            ConditionEnvironment = "XDG_CURRENT_DESKTOP=GNOME";
          };
          Service = {
            Type = "oneshot";
            ExecStart = ''${pkgs.dconf}/bin/dconf write /org/gnome/desktop/wm/preferences/button-layout "':minimize,maximize,close'"'';
            RemainAfterExit = "no";
          };
          Install = {
            WantedBy = [ "graphical-session.target" ];
          };
        };

        services.sway-dconf-apply = {
          Unit = {
            Description = "Disable WM button-layout";
            PartOf = [ "graphical-session.target" ];
            After = [ "graphical-session.target" ];
            ConditionEnvironment = "XDG_CURRENT_DESKTOP=sway";
          };
          Service = {
            Type = "oneshot";
            ExecStart = ''${pkgs.dconf}/bin/dconf write /org/gnome/desktop/wm/preferences/button-layout "' '" '';
            RemainAfterExit = "no";
          };
          Install = {
            WantedBy = [ "graphical-session.target" ];
          };
        };
      };

      xdg = {
        desktopEntries = {
          neovide = {
            type = "Application";
            exec = "neovide %F";
            icon = "nvim";
            name = "Neovide";
            settings = {
              Keywords = "Text;Editor;";
            };
            categories = [
              "Utility"
              "TextEditor"
            ];
            comment = "No Nonsense Neovim Client in Rust";
            mimeType = [
              "text/english"
              "text/plain"
              "text/x-makefile"
              "text/x-c++hdr"
              "text/x-c++src"
              "text/x-chdr"
              "text/x-csrc"
              "text/x-java"
              "text/x-moc"
              "text/x-pascal"
              "text/x-tcl"
              "text/x-tex"
              "application/x-shellscript"
              "text/x-c"
              "text/x-c++"
            ];
          };
        };
      };

      gtk = {
        enable = true;
        font = {
          package = pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrainsMono Nerd Font";
          size = 10;
        };
        iconTheme = {
          package = pkgs.papirus-icon-theme;
          name = "Papirus-Dark";
        };
        theme = {
          package = pkgs.mint-themes;
          name = "Mint-Y-Dark-Grey";
        };
        gtk3 = {
          extraConfig = {
            gtk-application-prefer-dark-theme = 1;
          };
        };
        gtk4 = {
          extraConfig = {
            gtk-application-prefer-dark-theme = 1;
          };
        };
      };

      services.mako = {
        enable = true;
        settings = {
          actions = true;
          anchor = "top-right";
          background-color = "${theme.colors.bg}";
          border-color = "${theme.colors.ifoc}";
          text-color = "${theme.colors.fg}";
          progress-color = "${theme.colors.inn}";
          border-size = theme.border-size;
          border-radius = theme.border-radius;
          default-timeout = 10000;
          font = theme.font + " " + theme.font-size;
          height = 100;
          width = 300;
          icons = true;
          icon-path = "${pkgs.papirus-icon-theme}";
          ignore-timeout = false;
          layer = "top";
          margin = theme.margin * 2;
          markup = true;
          "actionable=true" = {
            anchor = "top-right";
          };
        };
      };

      wayland.windowManager.sway =
        let
          mod = "Mod4";
          left = "h";
          down = "j";
          up = "k";
          right = "l";
          term = "ghostty";
          menu = "'rofi -modi drun,run -show drun'";
          i3_gaps_outer = 0;
          ws1 = "1";
          ws2 = "2";
          ws3 = "3";
          ws4 = "4";
          ws5 = "5";
          ws6 = "6";
          ws7 = "7";
          ws8 = "8";
          ws9 = "9";
          ws10 = "10";
        in
        {
          enable = true;
          package = pkgs.swayfx.override {
            extraOptions = [
              "--unsupported-gpu"
            ];
            extraSessionCommands = ''
              # SDL:
              export SDL_VIDEODRIVER=wayland
              # QT (needs qt5.qtwayland in systemPackages):
              export QT_QPA_PLATFORM=wayland-egl
              export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
              # Fix for some Java AWT applications (e.g. Android Studio),
              # use this if they aren't displayed properly:
              export _JAVA_AWT_WM_NONREPARENTING=1
            '';
            withBaseWrapper = true;
            withGtkWrapper = true;
          };
          config = {
            modifier = mod;
            terminal = term;
            menu = menu;
            left = left;
            down = down;
            up = up;
            right = right;
            fonts = {
              names = [ theme.font ];
              style = "SemiBold";
              size = theme.font-size;
            };
            gaps = {
              inner = theme.margin;
              outer = i3_gaps_outer;
              smartGaps = false;
            };
            window = {
              border = theme.border-size;
              commands = [
                {
                  criteria = {
                    all = true;
                  };
                  command = "title_window_icon off";
                }
              ];
              titlebar = false;
            };
            floating = {
              modifier = mod;
            };
            colors = {
              background = theme.colors.bg;
              focused = {
                border = theme.colors.afoc;
                background = theme.colors.afoc;
                text = theme.colors.bg;
                indicator = theme.colors.inn;
                childBorder = theme.colors.afoc;
              };
              focusedInactive = {
                border = theme.colors.ifoc;
                background = theme.colors.ifoc;
                text = theme.colors.bg;
                indicator = theme.colors.inn;
                childBorder = theme.colors.ifoc;
              };
              unfocused = {
                border = theme.colors.ufoc;
                background = theme.colors.ufoc;
                text = theme.colors.fg;
                indicator = theme.colors.inn;
                childBorder = theme.colors.ufoc;
              };
              urgent = {
                border = theme.colors.urgt;
                background = theme.colors.urgt;
                text = theme.colors.fg;
                indicator = theme.colors.inn;
                childBorder = theme.colors.urgt;
              };
              placeholder = {
                border = theme.colors.phol;
                background = theme.colors.phol;
                text = theme.colors.fg;
                indicator = theme.colors.inn;
                childBorder = theme.colors.phol;
              };
            };
            keybindings = {
              "${mod}+m" = "bar mode toggle";
              "${mod}+Shift+c" = "reload";
              "${mod}+Shift+r" = "restart";
              "${mod}+Shift+e" = "exec swaynag -f '${
                theme.font + " " + theme.font-size
              }' -t warning -m ' Exit request detected' -B 'Yes, exit sway' 'swaymsg exit'";
              "XF86AudioMute" = "exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle";
              "XF86AudioLowerVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -5%";
              "XF86AudioRaiseVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +5%";
              "XF86AudioMicMute" = "exec --no-startup-id pactl set-source-mute @DEFAULT_SOURCE@ toggle";
              "XF86MonBrightnessDown" = "exec --no-startup-id brightnessctl set 5%-";
              "XF86MonBrightnessUp" = "exec --no-startup-id brightnessctl set 5%+";
              "Print" = "exec grim";
              "${mod}+Return" = "exec ${term}";
              "${mod}+Shift+q" = "kill";
              "${mod}+d" = "exec ${menu}";
              "${mod}+${left}" = "focus left";
              "${mod}+${down}" = "focus down";
              "${mod}+${up}" = "focus up";
              "${mod}+${right}" = "focus right";
              "${mod}+Left" = "focus left";
              "${mod}+Down" = "focus down";
              "${mod}+Up" = "focus up";
              "${mod}+Right" = "focus right";
              "${mod}+space" = "focus mode_toggle";
              "${mod}+p" = "focus parent";
              "${mod}+n" = "focus child";
              "${mod}+Shift+${left}" = "move left";
              "${mod}+Shift+${down}" = "move down";
              "${mod}+Shift+${up}" = "move up";
              "${mod}+Shift+${right}" = "move right";
              "${mod}+Shift+Left" = "move left";
              "${mod}+Shift+Down" = "move down";
              "${mod}+Shift+Up" = "move up";
              "${mod}+Shift+Right" = "move right";
              "${mod}+r" = "split h";
              "${mod}+b" = "split v";
              "${mod}+f" = "fullscreen toggle";
              "${mod}+s" = "layout stacking";
              "${mod}+w" = "layout tabbed";
              "${mod}+e" = "layout toggle split";
              "${mod}+Shift+space" = "floating toggle";
              "${mod}+1" = "workspace number ${ws1}";
              "${mod}+2" = "workspace number ${ws2}";
              "${mod}+3" = "workspace number ${ws3}";
              "${mod}+4" = "workspace number ${ws4}";
              "${mod}+5" = "workspace number ${ws5}";
              "${mod}+6" = "workspace number ${ws6}";
              "${mod}+7" = "workspace number ${ws7}";
              "${mod}+8" = "workspace number ${ws8}";
              "${mod}+9" = "workspace number ${ws9}";
              "${mod}+0" = "workspace number ${ws10}";
              "${mod}+Shift+1" = "move container to workspace number ${ws1}";
              "${mod}+Shift+2" = "move container to workspace number ${ws2}";
              "${mod}+Shift+3" = "move container to workspace number ${ws3}";
              "${mod}+Shift+4" = "move container to workspace number ${ws4}";
              "${mod}+Shift+5" = "move container to workspace number ${ws5}";
              "${mod}+Shift+6" = "move container to workspace number ${ws6}";
              "${mod}+Shift+7" = "move container to workspace number ${ws7}";
              "${mod}+Shift+8" = "move container to workspace number ${ws8}";
              "${mod}+Shift+9" = "move container to workspace number ${ws9}";
              "${mod}+Shift+0" = "move container to workspace number ${ws10}";
              "${mod}+g" = "mode resize";
            };
            defaultWorkspace = "workspace number ${ws1}";
            modes = {
              resize = {
                "${left}" = "resize shrink width 1 px or 1 ppt";
                "${down}" = "resize grow height 1 px or 1 ppt";
                "${up}" = "resize shrink height 1 px or 1 ppt";
                "${right}" = "resize grow width 1 px or 1 ppt";
                "Left" = "resize shrink width 1 px or 1 ppt";
                "Down" = "resize grow height 1 px or 1 ppt";
                "Up" = "resize shrink height 1 px or 1 ppt";
                "Right" = "resize grow width 1 px or 1 ppt";
                "Return" = "mode default";
                "Escape" = "mode default";
                "${mod}+r" = "mode default";
              };
            };
            startup = [
              { command = "swaybg -m fill -i ${./config/wallpaper/16.jpeg}"; }
              { command = "discord --start-minimized"; }
              { command = "youtube-music"; }
              { command = "vivaldi"; }
              { command = "ghostty"; }
              {
                command = "systemctl --user restart kanshi.service";
                always = true;
              }
            ];
            bars = [
              {
                command = "${pkgs.waybar}/bin/waybar";
              }
            ];
          };
          checkConfig = false;
          extraConfig = ''
            corner_radius ${builtins.toString theme.border-radius}
            title_align center
            for_window [instance="vivaldi-stable"] move container to workspace number 2
            for_window [instance="com.github.th_ch.youtube_music"] move container to workspace number 10
            for_window [app_id="com.mitchellh.ghostty"] move container to workspace number 1
            input * {
                xkb_layout "us,br"
                xkb_options "grp:win_space_toggle"
            }
          '';
        };

      programs.waybar = {
        enable = true;
        settings = {
          mainBar = {
            layer = "bottom";
            position = "bottom";
            spacing = theme.margin;
            margin = "0px ${builtins.toString theme.margin}px ${builtins.toString theme.margin}px ${builtins.toString theme.margin}px";
            modules-left = [
              "sway/workspaces"
              "sway/mode"
              "tray"
            ];
            modules-center = [
              "clock"
            ];
            modules-right = [
              "sway/language"
              "network"
              "bluetooth"
              "pulseaudio"
            ];

            "sway/workspaces" = {
              disable-scroll = true;
              all-outputs = true;
              format = "{name}";
            };

            "sway/mode" = {
              "max-length" = 50;
            };

            "sway/language" = {
              format = "{}";
              on-click = "swaymsg input type:keyboard xkb_switch_layout next";
            };

            clock = {
              interval = 1;
              timezone = "America/Sao_Paulo";
              format = "{:%a %d-%m-%Y %I:%M %p}";
              tooltip = false;
            };

            tray = {
              icon-size = 16;
              spacing = theme.margin * 4;
            };

            network = {
              format-wifi = "<span color='${theme.colors.fg}'>󰖩 </span>{essid}";
              format-ethernet = "<span color='${theme.colors.fg}'>󰈁 </span>Wired";
              format-linked = "<span color='${theme.colors.fg}'>󰈁 </span>{ifname} (No IP)";
              format-disconnected = "<span color='${theme.colors.urgt}'>󰈂 </span>Disconnected";
              format-alt = "<span color='${theme.colors.fg}'>󰖩 </span>{signalStrength}%";
              interval = 1;
            };

            bluetooth = {
              format = "<span color='${theme.colors.fg}'>󰂯 </span>{status}";
              format-connected = "<span color='${theme.colors.fg}'>󰂯 </span>{device_alias}";
              format-connected-battery = "<span color='${theme.colors.fg}'>󰂯 </span>{device_alias}";
              tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
              tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
              tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
              tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
            };

            pulseaudio = {
              format = "<span color='${theme.colors.fg}'>{icon}</span>{volume}%";
              format-muted = "<span color='${theme.colors.urgt}'>󰖁 </span>0%";
              format-icons = {
                default = [
                  "<span color='${theme.colors.fg}'>󰕾 </span>"
                ];
              };
              on-click-right = "pavucontrol -t 3";
              on-click = "pactl -- set-sink-mute 0 toggle";
            };
          };
        };
        style = ''
          * {
            font-family: "${theme.font}";
            font-size: 14px;
            font-weight: 600;
            border-radius: ${builtins.toString theme.border-radius}px;
          }

          #waybar {
            color: ${theme.colors.fg};
            background-color: rgba(0, 0, 0, 0);
            box-shadow: none;
          }

          #network,
          #bluetooth,
          #clock,
          #mode,
          #pulseaudio,
          #language,
          #tray {
            border: ${builtins.toString theme.border-size}px solid ${theme.colors.ifoc};
            padding: 0px ${builtins.toString (theme.margin * 3)}px;
            background-color: ${theme.colors.bg};
          }

          #pulseaudio.muted {
            color: ${theme.colors.urgt};
          }

          #bluetooth:hover,
          #network:hover,
          #pulseaudio:hover,
          #clock:hover,
          #language:hover,
          #workspaces button:hover {
            background-color: ${theme.colors.bg};
          }

          #workspaces {
            border: ${builtins.toString theme.border-size}px solid ${theme.colors.ifoc};
          }

          #workspaces,
          #workspaces button,
          #workspaces button.visible,
          #workspaces button.focused,
          #workspaces button.persistent,
          #workspaces button.empty,
          #workspaces button.current_output {
            background-color: ${theme.colors.bg};
          }

          #workspaces button.urgent {
            background-color: ${theme.colors.bg};
            color: ${theme.colors.urgt};
          }

          #workspaces button.visible {
            color: ${theme.colors.afoc};
          }
        '';
      };

      programs.rofi = {
        enable = true;
        package = pkgs.rofi-wayland;
        extraConfig = {
          modi = "drun,run,filebrowser,window";
          case-sensitive = false;
          cycle = true;
          filter = "";
          scroll-method = 0;
          normalize-match = true;
          show-icons = false;
          icon-theme = "Papirus Dark";
          steal-focus = false;
          matching = "normal";
          tokenize = true;
          ssh-client = "ssh";
          ssh-command = "{terminal} -e {ssh-client} {host} [-p {port}]";
          parse-hosts = true;
          parse-known-hosts = true;
          drun-categories = "";
          drun-match-fields = "name,generic,exec,categories,keywords";
          drun-display-format = "{name} [<span weight='light' size='small'><i>({generic})</i></span>]";
          drun-show-actions = false;
          drun-url-launcher = "xdg-open";
          drun-use-desktop-cache = false;
          drun-reload-desktop-cache = false;
          run-command = "{cmd}";
          run-list-command = "";
          run-shell-command = "{terminal} -e {cmd}";
          window-match-fields = "title,class,role,name,desktop";
          window-command = "wmctrl -i -R {window}";
          window-format = "{w} - {c} - {t:0}";
          window-thumbnail = false;
          combi-modi = "window,run";
          combi-hide-mode-prefix = false;
          combi-display-format = "{mode} {text}";
          disable-history = false;
          sorting-method = "normal";
          max-history-size = 25;
          display-window = "Windows";
          display-windowcd = "Window CD";
          display-run = "Run";
          display-ssh = "SSH";
          display-drun = "Apps";
          display-combi = "Combi";
          display-keys = "Keys";
          display-filebrowser = "Files";
          terminal = "rofi-sensible-terminal";
          font = "JetBrainsMono NF SemiBold 10";
          sort = false;
          threads = 0;
          click-to-exit = true;
        };
        theme =
          let
            mkLiteral = value: {
              _type = "literal";
              inherit value;
            };
          in
          {
            "*" = {
              active-background = mkLiteral "${theme.colors.bg}";
              active-foreground = mkLiteral "${theme.colors.afoc}";
              alternate-active-background = mkLiteral "${theme.colors.bg}";
              alternate-active-foreground = mkLiteral "@active-foreground";
              alternate-normal-background = mkLiteral "${theme.colors.bg}";
              alternate-normal-foreground = mkLiteral "@foreground";
              alternate-urgent-background = mkLiteral "${theme.colors.bg}";
              alternate-urgent-foreground = mkLiteral "@urgent-foreground";
              background = mkLiteral "${theme.colors.bg}";
              background-color = mkLiteral "${theme.colors.bg}";
              border-color = mkLiteral "${theme.colors.ifoc}";
              foreground = mkLiteral "${theme.colors.fg}";
              normal-background = mkLiteral "${theme.colors.bg}";
              normal-foreground = mkLiteral "@foreground";
              selected-active-background = mkLiteral "${theme.colors.afoc}";
              selected-active-foreground = mkLiteral "${theme.colors.bg}";
              selected-normal-background = mkLiteral "${theme.colors.afoc}";
              selected-normal-foreground = mkLiteral "${theme.colors.bg}";
              selected-urgent-background = mkLiteral "${theme.colors.urgt}";
              selected-urgent-foreground = mkLiteral "${theme.colors.bg}";
              separatorcolor = mkLiteral "${theme.colors.ifoc}";
              spacing = mkLiteral "0";
              urgent-background = mkLiteral "${theme.colors.bg}";
              urgent-foreground = mkLiteral "${theme.colors.urgt}";
            };
            "window" = {
              background-color = mkLiteral "@background";
              border = theme.border-size;
              border-radius = theme.border-radius;
              padding = 0;
            };
            "mainbox" = {
              border = 0;
              padding = 0;
            };
            "message" = {
              border = mkLiteral "0px 0px 0px";
              border-color = mkLiteral "@separatorcolor";
              padding = mkLiteral "0px";
            };
            "textbox" = {
              text-color = mkLiteral "@foreground";
            };
            "listview" = {
              fixed-height = 0;
              border = mkLiteral "0px";
              border-color = mkLiteral "@separatorcolor";
              spacing = mkLiteral "0px";
              scrollbar = true;
              padding = mkLiteral "0px";
            };
            "element" = {
              border = 0;
              padding = mkLiteral "8px";
            };
            "element-text" = {
              background-color = mkLiteral "inherit";
              text-color = mkLiteral "inherit";
            };
            "element.normal.normal" = {
              background-color = mkLiteral "@normal-background";
              text-color = mkLiteral "@normal-foreground";
            };
            "element.normal.urgent" = {
              background-color = mkLiteral "@urgent-background";
              text-color = mkLiteral "@urgent-foreground";
            };
            "element.normal.active" = {
              background-color = mkLiteral "@active-background";
              text-color = mkLiteral "@active-foreground";
            };
            "element.selected.normal" = {
              background-color = mkLiteral "@selected-normal-background";
              text-color = mkLiteral "@selected-normal-foreground";
            };
            "element.selected.urgent" = {
              background-color = mkLiteral "@selected-urgent-background";
              text-color = mkLiteral "@selected-urgent-foreground";
            };
            "element.selected.active" = {
              background-color = mkLiteral "@selected-active-background";
              text-color = mkLiteral "@selected-active-foreground";
            };
            "element.alternate.normal" = {
              background-color = mkLiteral "@alternate-normal-background";
              text-color = mkLiteral "@alternate-normal-foreground";
            };
            "element.alternate.urgent" = {
              background-color = mkLiteral "@alternate-urgent-background";
              text-color = mkLiteral "@alternate-urgent-foreground";
            };
            "element.alternate.active" = {
              background-color = mkLiteral "@alternate-active-background";
              text-color = mkLiteral "@alternate-active-foreground";
            };
            "scrollbar" = {
              width = mkLiteral "0px";
              border = 0;
              handle-width = mkLiteral "0px";
              padding = 0;
            };
            "mode-switcher" = {
              border = mkLiteral "0px";
              border-color = mkLiteral "@separatorcolor";
            };
            "button.selected" = {
              background-color = mkLiteral "@selected-normal-background";
              text-color = mkLiteral "@selected-normal-foreground";
            };
            "inputbar" = {
              spacing = 0;
              text-color = mkLiteral "@normal-foreground";
              padding = mkLiteral "8px";
              border = mkLiteral "0 0 ${builtins.toString theme.border-size}px 0";
              children = [
                "prompt"
                "textbox-prompt-colon"
                "entry"
                "case-indicator"
              ];
            };
            "case-indicator" = {
              spacing = 0;
              text-color = mkLiteral "@normal-foreground";
            };
            "entry" = {
              spacing = 0;
              text-color = mkLiteral "@normal-foreground";
            };
            "prompt" = {
              spacing = 0;
              text-color = mkLiteral "@normal-foreground";
            };
            "textbox-prompt-colon" = {
              expand = false;
              str = " λ ";
              margin = mkLiteral "0px";
              text-color = mkLiteral "@normal-foreground";
            };
          };
      };

      programs.bash = {
        enable = true;
        enableCompletion = true;
        historyControl = [
          "ignoredups"
          "erasedups"
        ];
        historyIgnore = [
          "ls"
          "cd"
          "exit"
        ];
        shellOptions = [
          "histappend"
          "checkwinsize"
          "extglob"
          "globstar"
          "checkjobs"
        ];
        initExtra = ''
          PS1='\[\e[0;92m\]\u\[\e[0m\]@\[\e[0;95m\]\h \[\e[0m\]on \[\e[0;94m\]\w\n\[\e[0;93m\]λ \[\e[0m\]'
          export FZF_DEFAULT_OPTS='--color bg+:${theme.colors.bg} --color bg:${theme.colors.bg} --color spinner:${gruvbox_12} --color hl:${gruvbox_12} --color fg:${gruvbox_12} --color header:${gruvbox_12} --color info:${gruvbox_10} --color pointer:${gruvbox_9} --color marker:${gruvbox_12} --color fg+:${gruvbox_12} --color prompt:${gruvbox_12} --color hl+:${gruvbox_12} --border="rounded" --border-label="" --preview-window="border-rounded" --prompt="> " --marker=">" --pointer="◆" --separator="─" --scrollbar="│"'
        '';
        shellAliases = {
          b = "bat";
          clear = ''
            clear &&
              rm -rf \
                "$HOME"/.bash_history \
                "$HOME"/.java \
                "$HOME"/.lesshst \
                "$HOME"/.nv \
                "$HOME"/.wget-hsts \
                "$HOME"/.xsession-errors* &&
              history -c'';
          # la = "exa -a";
          # ll = "exa -la";
          # ls = "exa";
          nv = "neovide --fork";
          nixs = "sudo nixos-rebuild switch";
          nixb = "sudo nixos-rebuild boot";
          ".." = "cd ..";
        };
      };

      programs.readline = {
        enable = true;
        variables = {
          completion-ignore-case = true;
        };
      };

      programs.git = {
        enable = true;
        userEmail = "antoniomayk.g@gmail.com";
        userName = "antoniomayk";
      };

      programs.ghostty = {
        enable = true;
        enableBashIntegration = true;
        installBatSyntax = true;
        installVimSyntax = true;
        settings = {
          gtk-adwaita = false;
          font-family = "JetBrainsMono NF";
          font-size = 14;
          window-padding-x = 4;
          window-padding-y = 4;
          window-padding-balance = true;
          window-padding-color = "extend-always";
          window-height = 30;
          window-width = 120;
          palette = [
            "0=${gruvbox_0}"
            "1=${gruvbox_1}"
            "2=${gruvbox_2}"
            "3=${gruvbox_3}"
            "4=${gruvbox_4}"
            "5=${gruvbox_5}"
            "6=${gruvbox_6}"
            "7=${gruvbox_7}"
            "8=${gruvbox_8}"
            "9=${gruvbox_9}"
            "10=${gruvbox_10}"
            "11=${gruvbox_11}"
            "12=${gruvbox_12}"
            "13=${gruvbox_13}"
            "14=${gruvbox_14}"
            "15=${gruvbox_15}"
          ];
          background = "${theme.colors.bg}";
          foreground = "${gruvbox_15}";
          cursor-color = "${gruvbox_15}";
          cursor-text = "${gruvbox_0}";
          selection-background = "${gruvbox_7}";
          selection-foreground = "${gruvbox_15}";
        };
      };

      programs.bat = {
        enable = true;
        config = {
          map-syntax = [
            "*.jenkinsfile:Groovy"
            "*.props:Java Properties"
          ];
          pager = "less -FR";
          theme = "gruvbox-dark";
        };
      };

      programs.neovim =
        let
          lsps = with pkgs; [
            clang-tools
            coursier
            docker-compose-language-service
            dockerfile-language-server-nodejs
            jdt-language-server
            lemminx
            lombok
            lua-language-server
            metals
            nixd
            nixfmt-rfc-style
            rust-analyzer
          ];
          linters = with pkgs; [
            checkstyle
            yamllint
            sqlfluff
          ];
          formatters = with pkgs; [
            black
            cmake-format
            fourmolu
            google-java-format
            isort
            rustfmt
            scalafmt
            shfmt
            stylish-haskell
            stylua
            xmlformat
          ];
        in
        {
          enable = true;
          defaultEditor = true;
          viAlias = true;
          vimAlias = true;
          vimdiffAlias = true;
          extraPackages = builtins.concatLists [
            lsps
            linters
            formatters
          ];
          extraLuaConfig = (
            builtins.concatStringsSep "\n" [
              (readAndPadFile ./config/nvim/options.lua)
              (readAndPadFile ./config/nvim/mappings.lua)
              (readAndPadFile ./config/nvim/misc.lua)
              (readAndPadFile ./config/nvim/plugins/blink.lua)
              (readAndPadFile ./config/nvim/plugins/bufferline.lua)
              (readAndPadFile ./config/nvim/plugins/conform.lua)
              (readAndPadFile ./config/nvim/plugins/gruvbox.lua)
              (readAndPadFile ./config/nvim/plugins/highlight-colors.lua)
              (readAndPadFile ./config/nvim/plugins/lualine.lua)
              (readAndPadFile ./config/nvim/plugins/noice.lua)
              (readAndPadFile ./config/nvim/plugins/lint.lua)
              (readAndPadFile ./config/nvim/plugins/rendermarkdown.lua)
              (readAndPadFile ./config/nvim/plugins/snacks.lua)
              (readAndPadFile ./config/nvim/plugins/treesitter.lua)
              (readAndPadFile ./config/nvim/plugins/whichkey.lua)
              (builtins.replaceStrings [ "{{{lombok}}}" ] [ "${pkgs.lombok}" ]
                (readAndPadFile ./config/nvim/lsp.lua)
              )
            ]
          );
          plugins = with pkgs.vimPlugins; [
            blink-cmp
            bufferline-nvim
            conform-nvim
            flash-nvim
            friendly-snippets
            grug-far-nvim
            gruvbox-nvim
            guess-indent-nvim
            lualine-nvim
            noice-nvim
            nvim-lint
            nvim-highlight-colors
            nvim-jdtls
            nvim-metals
            nvim-surround
            nvim-web-devicons
            rainbow-delimiters-nvim
            render-markdown-nvim
            snacks-nvim
            todo-comments-nvim
            vim-suda
            which-key-nvim
            (nvim-treesitter.withPlugins (p: [
              p.tree-sitter-bash
              p.tree-sitter-c
              p.tree-sitter-cmake
              p.tree-sitter-cpp
              p.tree-sitter-css
              p.tree-sitter-go
              p.tree-sitter-haskell
              p.tree-sitter-html
              p.tree-sitter-java
              p.tree-sitter-json
              p.tree-sitter-lua
              p.tree-sitter-make
              p.tree-sitter-markdown
              p.tree-sitter-markdown_inline
              p.tree-sitter-nix
              p.tree-sitter-ini
              p.tree-sitter-python
              p.tree-sitter-rust
              p.tree-sitter-scala
              p.tree-sitter-scss
              p.tree-sitter-sql
              p.tree-sitter-toml
              p.tree-sitter-typescript
              p.tree-sitter-vim
              p.tree-sitter-vimdoc
              p.tree-sitter-xml
              p.tree-sitter-yaml
            ]))
          ];
        };

      programs.fzf = {
        enable = true;
        enableBashIntegration = true;
      };

      programs.neovide = {
        enable = true;
        settings = {
          fork = false;
          frame = "full";
          idle = true;
          maximized = false;
          no-multigrid = false;
          srgb = false;
          tabs = true;
          theme = "auto";
          title-hidden = true;
          vsync = true;
          wsl = false;
          font = {
            edging = "subpixelantialias";
            hinting = "normal";
            normal = [ "JetBrainsMono NF" ];
            size = 14.0;
          };
        };
      };

      programs.firefox = {
        enable = true;
      };

      programs.zathura = {
        enable = true;
        extraConfig = ''
          set window-title-basename "true"
          set selection-clipboard "clipboard"
          set adjust-open "best-fit"
          set pages-per-row 1
          set scroll-page-aware "true"
          set smooth-scroll "true"
          set scroll-full-overlap 0.01
          set scroll-step 100
          set zoom-min 10
          set guioptions ""
          set adjust-open width
          set recolor true
          set font "${theme.font} ${theme.font-size}"
          set render-loading "false"
          set scroll-step 50

          unmap i
          map i recolor

          unmap f
          map f toggle_fullscreen
          map [fullscreen] f toggle_fullscreen

          set notification-error-bg       "${theme.colors.urgt}"   # Red
          set notification-error-fg       "${theme.colors.fg}"     # Foreground
          set notification-warning-bg     "${theme.colors.warn}"   # Orange
          set notification-warning-fg     "${theme.colors.bg}"     # Selection
          set notification-bg             "${theme.colors.bg}"     # Background
          set notification-fg             "${theme.colors.fg}"     # Foreground

          set completion-bg               "${theme.colors.bg}"     # Background
          set completion-fg               "${theme.colors.fg}"     # Comment
          set completion-group-bg         "${theme.colors.bg}"     # Background
          set completion-group-fg         "${theme.colors.fg}"     # Comment
          set completion-highlight-bg     "${theme.colors.bg}"     # Selection
          set completion-highlight-fg     "${theme.colors.fg}"     # Foreground

          set index-bg                    "${theme.colors.bg}"     # Background
          set index-fg                    "${theme.colors.fg}"     # Foreground
          set index-active-bg             "${theme.colors.afoc}"   # Current Line
          set index-active-fg             "${theme.colors.bg}"     # Foreground

          set inputbar-bg                 "${theme.colors.bg}"     # Background
          set inputbar-fg                 "${theme.colors.fg}"     # Foreground
          set statusbar-bg                "${theme.colors.bg}"     # Background
          set statusbar-fg                "${theme.colors.fg}"     # Foreground

          set highlight-fg                "rgba(131, 165, 152, 0.5)"
          set highlight-color             "rgba(250, 189, 47, 0.5)"
          set highlight-active-color      "rgba(184, 187, 38, 0.5)"

          set default-bg                  "${theme.colors.bg}"     # Background
          set default-fg                  "${theme.colors.fg}"     # Foreground

          set render-loading              true
          set render-loading-fg           ${theme.colors.bg}"    # Background
          set render-loading-bg           ${theme.colors.fg}"    # Foreground

          set recolor-lightcolor          ${theme.colors.bg}"
          set recolor-darkcolor           ${theme.colors.fg}"
        '';
      };

      programs.zoxide = {
        enable = true;
        enableBashIntegration = true;
      };

      home.stateVersion = "25.05";
    };

}
