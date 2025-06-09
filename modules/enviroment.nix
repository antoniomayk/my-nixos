{ pkgs, ... }:

{
  environment.gnome.excludePackages = with pkgs; [
    baobab
    cheese
    eog
    epiphany
    evince
    geary
    gedit
    gnome-connections
    gnome-console
    gnome-contacts
    gnome-font-viewer
    gnome-logs
    gnome-maps
    gnome-music
    gnome-music
    gnome-photos
    gnome-text-editor
    gnome-tour
    nixos-render-docs
    seahorse
    simple-scan
    totem
    yelp
  ];

  environment.systemPackages = with pkgs; [
    bat
    docker-compose
    eza
    fd
    fzf
    git
    git-lfs
    lshw
    pciutils
    qemu
    ripgrep
    tldr
    unrar
    unzip
    virt-manager
    wget
    xclip
    zip
  ];
  
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = [ ];
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  xdg = {
    terminal-exec = {
      enable = true;
      settings = {
        default = [
          "ghostty.desktop"
        ];
      };
    };
  };
}
