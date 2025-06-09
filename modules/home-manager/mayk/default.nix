{ ... }:

let
  readAndPadFile = file: "\n${builtins.readFile file}\n";
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
        lazydocker
        lazygit
        neofetch
        obsidian
        papers
        vivaldi
        vivaldi-ffmpeg-codecs
        youtube-music
      ];
      dconf.settings = {
        "org/virt-manager/virt-manager/connections" = {
          autoconnect = [ "qemu:///system" ];
          uris = [ "qemu:///system" ];
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
        # gtk3 = {
        #   extraConfig = {
        #     gtk-application-prefer-dark-theme = 1;
        #   };
        # };
        # gtk4 = {
        #   extraConfig = {
        #     gtk-application-prefer-dark-theme = 1;
        #   };
        # };
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
        # ─
        initExtra = ''
          PS1='\[\e[0m\]┌\[\e[0;92m\]\u\[\e[0m\]@\[\e[0;95m\]\h \[\e[0m\]on \[\e[0;94m\]\w\n\[\e[0m\]└\[\e[0;93m\]λ \[\e[0m\]'

          export FZF_DEFAULT_OPTS='--color bg+:#000000 --color bg:#000000 --color spinner:#83a598 --color hl:#83a598 --color fg:#ebdbb2 --color header:#83a598 --color info:#b8bb26 --color pointer:#fb4934 --color marker:#83a598 --color fg+:#83a598 --color prompt:#83a598 --color hl+:#83a598 --border="rounded" --border-label="" --preview-window="border-rounded" --prompt="> " --marker=">" --pointer="◆" --separator="─" --scrollbar="│"'
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
            "0=#1d2021"
            "1=#cc241d"
            "2=#98971a"
            "3=#d79921"
            "4=#458588"
            "5=#b16286"
            "6=#689d6a"
            "7=#a89984"
            "8=#928374"
            "9=#fb4934"
            "10=#b8bb26"
            "11=#fabd2f"
            "12=#83a598"
            "13=#d3869b"
            "14=#8ec07c"
            "15=#ebdbb2"
          ];
          background = "#000000";
          foreground = "#ebdbb2";
          cursor-color = "#ebdbb2";
          cursor-text = "#1d2021";
          selection-background = "#665c54";
          selection-foreground = "#ebdbb2";
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

      home.stateVersion = "25.05";
    };
}
