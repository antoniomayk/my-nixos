{ pkgs, ... }:

{
  services = {
    xserver = {
      enable = true;
      excludePackages = with pkgs; [
        xterm
      ];
      exportConfiguration = true;
      videoDrivers = [ "nvidia" ];
      desktopManager.cinnamon.enable = true;
      displayManager.lightdm = {
        enable = true;
        greeters.slick.enable = false;
        greeters.gtk = {
          enable = true;
          theme = {
            package = pkgs.mint-themes;
            name = "Mint-Y-Dark-Grey";
          };
          iconTheme = {
            package = pkgs.papirus-icon-theme;
            name = "Papirus-Dark";
          };
          extraConfig = ''
            font-name = JetBrainsMono Nerd Font 10
          '';
        };
      };
      xkb = {
        layout = "us";
        variant = "";
      };
    };
    libinput.enable = true;
    printing.enable = true;
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
    openssh.enable = false;
  };

  security.rtkit.enable = true;
}
