{ config, ... }:

{
  services.murmur = {
    enable = true;
    bonjour = true;
    # registerHostname = "talk.janastu.org.";
    # registerName = "janastu";
  };

  networking.firewall.allowedTCPPorts = [ config.services.murmur.port ];
  networking.firewall.allowedUDPPorts = [ config.services.murmur.port ];
}
