{ pkgs, ... }:

{
  services = {
    xserver = {
      enable = true;
      excludePackages = with pkgs; [
        xterm
      ];
      videoDrivers = [ "nvidia" ];
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
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
