{ ... }:

{
  networking = {
    hostName = "nixosh";
    networkmanager.enable = true;
    firewall.allowedTCPPorts = [ ];
    firewall.allowedUDPPorts = [ ];
    firewall.enable = true;
  };

  time.timeZone = "America/Fortaleza";
}
