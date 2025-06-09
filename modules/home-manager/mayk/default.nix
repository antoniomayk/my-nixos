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
    adw = {
      bg = "#000000";
      fg = "#ffffff";
      inn = "#26a269";
      afoc = "#3584E4";
      ifoc = "#333336";
      ufoc = "#1d1d20";
      urgt = "#c01c28";
      warn = "#cd9309";
      phol = "#000000";
    };
  };

  clr = colors.gruvbox;

  border_size = 2;
in
{
  home-manager.users.mayk =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        discord
        foliate
        ghostty
        gnome-tweaks
        gnomeExtensions.alphabetical-app-grid
        gnomeExtensions.blur-my-shell
        gnomeExtensions.caffeine
        gnomeExtensions.just-perfection
        gnomeExtensions.rounded-window-corners-reborn
        gnomeExtensions.tray-icons-reloaded
        grim
        lazydocker
        lazygit
        neofetch
        obsidian
        papers
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
        "org/gnome/desktop/wm/preferences" = {
          button-layout = "";
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
          package = pkgs.adw-gtk3;
          name = "adw-gtk3-dark";
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
          background-color = "${clr.bg}";
          border-color = "${clr.ifoc}";
          text-color = "${clr.fg}";
          progress-color = "${clr.inn}";
          border-size = border_size;
          border-radius = 0;
          default-timeout = 10000;
          font = "JetBrainsMono Nerd Font 10";
          height = 100;
          width = 300;
          icons = true;
          icon-path = "${pkgs.papirus-icon-theme}";
          ignore-timeout = false;
          layer = "top";
          margin = 10;
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
          i3_fonts = "JetBrainsMono Nerd Font 10";
          i3_border_size = border_size;
          i3_border_style = "pixel";
          i3_gaps_inner = 0;
          i3_gaps_outer = 0;
          ws1 = "1:󰼏";
          ws2 = "2:󰼐";
          ws3 = "3:󰼑";
          ws4 = "4:󰼒";
          ws5 = "5:󰼓";
          ws6 = "6:󰼔";
          ws7 = "7:󰼕";
          ws8 = "8:󰼖";
          ws9 = "9:󰼗";
          ws10 = "10:󰼎";
        in
        {
          enable = true;
          wrapperFeatures.gtk = true;
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
          config = {
            modifier = mod;
            terminal = term;
            menu = menu;
            left = left;
            down = down;
            up = up;
            right = right;
            fonts = {
              names = [ "JetBrainsMono Nerd Font" ];
              style = "SemiBold";
              size = 10.0;
            };
            gaps = {
              inner = i3_gaps_inner;
              outer = i3_gaps_outer;
              smartGaps = false;
            };
            window = {
              border = i3_border_size;
              # hideEdgeBorders = "smart_no_gaps";
              commands = [
                {
                  criteria = {
                    all = true;
                  };
                  command = "border ${i3_border_style} ${toString i3_border_size}";
                }
                {
                  criteria = {
                    all = true;
                  };
                  command = "title_window_icon off";
                }
              ];
              titlebar = true;
            };
            floating = {
              modifier = mod;
            };
            colors = {
              background = clr.bg;
              focused = {
                border = clr.afoc;
                background = clr.afoc;
                text = clr.bg;
                indicator = clr.inn;
                childBorder = clr.afoc;
              };
              focusedInactive = {
                border = clr.ifoc;
                background = clr.ifoc;
                text = clr.bg;
                indicator = clr.inn;
                childBorder = clr.ifoc;
              };
              unfocused = {
                border = clr.ufoc;
                background = clr.ufoc;
                text = clr.fg;
                indicator = clr.inn;
                childBorder = clr.ufoc;
              };
              urgent = {
                border = clr.urgt;
                background = clr.urgt;
                text = clr.fg;
                indicator = clr.inn;
                childBorder = clr.urgt;
              };
              placeholder = {
                border = clr.phol;
                background = clr.phol;
                text = clr.fg;
                indicator = clr.inn;
                childBorder = clr.phol;
              };
            };
            keybindings = {
              "${mod}+m" = "bar mode toggle";
              "${mod}+Shift+c" = "reload";
              "${mod}+Shift+r" = "restart";
              "${mod}+Shift+e" =
                "exec swaynag -f '${i3_fonts}' -t warning -m ' Exit request detected' -B 'Yes, exit sway' 'swaymsg exit'";
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
              "${mod}+1" = "workspace ${ws1}";
              "${mod}+2" = "workspace ${ws2}";
              "${mod}+3" = "workspace ${ws3}";
              "${mod}+4" = "workspace ${ws4}";
              "${mod}+5" = "workspace ${ws5}";
              "${mod}+6" = "workspace ${ws6}";
              "${mod}+7" = "workspace ${ws7}";
              "${mod}+8" = "workspace ${ws8}";
              "${mod}+9" = "workspace ${ws9}";
              "${mod}+0" = "workspace ${ws10}";
              "${mod}+Shift+1" = "move container to workspace ${ws1}";
              "${mod}+Shift+2" = "move container to workspace ${ws2}";
              "${mod}+Shift+3" = "move container to workspace ${ws3}";
              "${mod}+Shift+4" = "move container to workspace ${ws4}";
              "${mod}+Shift+5" = "move container to workspace ${ws5}";
              "${mod}+Shift+6" = "move container to workspace ${ws6}";
              "${mod}+Shift+7" = "move container to workspace ${ws7}";
              "${mod}+Shift+8" = "move container to workspace ${ws8}";
              "${mod}+Shift+9" = "move container to workspace ${ws9}";
              "${mod}+Shift+0" = "move container to workspace ${ws10}";
              "${mod}+g" = "mode resize";
            };
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
            assigns = {
              "${ws1}" = [ { class = "com.mitchellh.ghostty"; } ];
              "${ws2}" = [
                { class = "Vivaldi-stable"; }
                { class = "Brave-browser"; }
              ];
              "${ws3}" = [
                { class = "jetbrains-datagrip"; }
                { class = "Insomnia"; }
              ];
              "${ws4}" = [ { class = "Nemo"; } ];
              "${ws6}" = [ { class = "Gnome-system-monitor"; } ];
              "${ws9}" = [
                {
                  class = "Vivaldi-stable";
                  title = "Focus To-Do - Vivaldi";
                }
              ];
              "${ws10}" = [ { class = "obsidian"; } ];
            };
            startup = [
              { command = "swaybg -m fill -i ${./config/wallpaper/14.png}"; }
              {
                command = "systemctl --user restart kanshi.service";
                always = true;
              }
            ];
            bars = [
              {
                position = "top";
                mode = "invisible";
                hiddenState = "hide";
                statusCommand = "${pkgs.i3status}/bin/i3status";
                fonts = {
                  names = [ "JetBrainsMono Nerd Font" ];
                  style = "SemiBold";
                  size = 10.0;
                };
                trayOutput = "*";
                trayPadding = 8;
                workspaceButtons = true;

                colors = {
                  background = clr.bg;
                  statusline = clr.fg;
                  separator = clr.fg;
                  focusedWorkspace = {
                    border = clr.bg;
                    background = clr.bg;
                    text = clr.fg;
                  };
                  activeWorkspace = {
                    border = clr.bg;
                    background = clr.bg;
                    text = clr.bg;
                  };
                  inactiveWorkspace = {
                    border = clr.bg;
                    background = clr.bg;
                    text = clr.ifoc;
                  };
                  urgentWorkspace = {
                    border = clr.bg;
                    background = clr.bg;
                    text = clr.urgt;
                  };
                  bindingMode = {
                    border = clr.bg;
                    background = clr.bg;
                    text = clr.urgt;
                  };
                };
                extraConfig = ''
                  binding_mode_indicator yes
                  icon_theme "Papirus-Dark"
                  modifier none
                  separator_symbol ""
                  status_padding 6
                  strip_workspace_name false
                  strip_workspace_numbers true
                  workspace_min_width 24
                '';
              }
            ];
          };
          extraConfig = ''
            title_align center
          '';
        };

      programs.i3status = {
        enable = true;
        enableDefault = false;
        general = {
          output_format = "i3bar";
          colors = true;
          interval = 5;
          color_good = "${clr.afoc}";
          color_bad = "${clr.urgt}";
          color_degraded = "${clr.warn}";
          markup = "pango";
        };
        modules = {
          "volume master" = {
            position = 0;
            settings = {
              format = "<span bgcolor='${clr.bg}' foreground='${clr.fg}'> 󰕾  %volume</span>";
              format_muted = "<span bgcolor='${clr.bg}' foreground='${clr.urgt}'> 󰝟  %volume</span>";
              device = "default";
              mixer = "Master";
              mixer_idx = 0;
            };
          };
          "wireless _first_" = {
            position = 1;
            settings = {
              format_up = "<span bgcolor='${clr.bg}' foreground='${clr.fg}'> 󰖩 %quality %essid [%ip]</span>";
              format_down = "<span bgcolor='${clr.bg}' foreground='${clr.urgt}'> 󰖪  Disconnected</span>";
            };
          };
          "ethernet _first_" = {
            position = 2;
            settings = {
              format_up = "<span bgcolor='${clr.bg}' foreground='${clr.fg}'> 󰈁 %ip</span>";
              format_down = "<span bgcolor='${clr.bg}' foreground='${clr.urgt}'> 󰈂 Disconnected</span>";
            };
          };
          "disk '/'" = {
            position = 3;
            settings = {
              format = "<span bgcolor='${clr.bg}' foreground='${clr.fg}'> 󰋊  %avail</span>";
              prefix_type = "custom";
            };
          };
          memory = {
            position = 4;
            settings = {
              format = "<span bgcolor='${clr.bg}' foreground='${clr.fg}'> 󰍛  %used</span>";
              threshold_degraded = "10%";
              format_degraded = "MEMORY: %free";
            };
          };
          cpu_usage = {
            position = 5;
            settings = {
              format = "<span bgcolor='${clr.bg}' foreground='${clr.fg}'> 󰘚  %usage</span>";
            };
          };
          "tztime localtime" = {
            position = 6;
            settings = {
              format = "<span bgcolor='${clr.bg}' foreground='${clr.fg}'> 󰸗  %a %d-%m-%Y %I:%M %p</span>";
            };
          };
        };
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
              active-background = mkLiteral "${clr.bg}";
              active-foreground = mkLiteral "${clr.afoc}";
              alternate-active-background = mkLiteral "${clr.bg}";
              alternate-active-foreground = mkLiteral "@active-foreground";
              alternate-normal-background = mkLiteral "${clr.bg}";
              alternate-normal-foreground = mkLiteral "@foreground";
              alternate-urgent-background = mkLiteral "${clr.bg}";
              alternate-urgent-foreground = mkLiteral "@urgent-foreground";
              background = mkLiteral "${clr.bg}";
              background-color = mkLiteral "${clr.bg}";
              border-color = mkLiteral "${clr.ifoc}";
              foreground = mkLiteral "${clr.fg}";
              normal-background = mkLiteral "${clr.bg}";
              normal-foreground = mkLiteral "@foreground";
              selected-active-background = mkLiteral "${clr.afoc}";
              selected-active-foreground = mkLiteral "${clr.bg}";
              selected-normal-background = mkLiteral "${clr.afoc}";
              selected-normal-foreground = mkLiteral "${clr.bg}";
              selected-urgent-background = mkLiteral "${clr.urgt}";
              selected-urgent-foreground = mkLiteral "${clr.bg}";
              separatorcolor = mkLiteral "${clr.ifoc}";
              spacing = mkLiteral "0";
              urgent-background = mkLiteral "${clr.bg}";
              urgent-foreground = mkLiteral "${clr.urgt}";
            };
            "window" = {
              background-color = mkLiteral "@background";
              border = border_size;
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
              border = mkLiteral "0 0 ${builtins.toString border_size}px 0";
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
          PS1='\[\e[0m\]┌\[\e[0;92m\]\u\[\e[0m\]@\[\e[0;95m\]\h \[\e[0m\]on \[\e[0;94m\]\w\n\[\e[0m\]└\[\e[0;93m\]λ \[\e[0m\]'
          export FZF_DEFAULT_OPTS='--color bg+:${clr.bg} --color bg:${clr.bg} --color spinner:${gruvbox_12} --color hl:${gruvbox_12} --color fg:${gruvbox_12} --color header:${gruvbox_12} --color info:${gruvbox_10} --color pointer:${gruvbox_9} --color marker:${gruvbox_12} --color fg+:${gruvbox_12} --color prompt:${gruvbox_12} --color hl+:${gruvbox_12} --border="rounded" --border-label="" --preview-window="border-rounded" --prompt="> " --marker=">" --pointer="◆" --separator="─" --scrollbar="│"'
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
          la = "exa -a";
          ll = "exa -la";
          ls = "exa";
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
          font-family = "JetBrainsMono NF";
          font-size = 14;
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
          background = "${clr.bg}";
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

      home.stateVersion = "25.05";
    };
}
