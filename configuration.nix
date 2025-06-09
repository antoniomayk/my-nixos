{ ... }:

{
  imports = [
    ./hardware-configuration.nix

    ./modules/boot.nix
    ./modules/enviroment.nix
    ./modules/hardware.nix
    ./modules/home-manager
    ./modules/i18n.nix
    ./modules/networking.nix
    ./modules/nix.nix
    ./modules/services.nix
    ./modules/users.nix
    ./modules/virtualisation.nix
  ];

  system.stateVersion = "25.05";
}
