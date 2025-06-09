{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bat
    distrobox
    docker-compose
    eza
    fd
    fzf
    git
    git-lfs
    lshw
    nerd-fonts.jetbrains-mono
    papirus-icon-theme
    pciutils
    pkgs.mint-themes
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

  environment.localBinInPath = true;

  programs.sway = {
    enable = true;
    package = pkgs.swayfx;
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
