{ ... }:

{
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
  };
  virtualisation.libvirtd ={
    enable = true;
  };
  virtualisation.spiceUSBRedirection.enable = true;
}
