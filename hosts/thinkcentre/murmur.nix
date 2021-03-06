{ config, ... }:

let fqdn = "mumble.janastu.org";
in {
  services.murmur = {
    enable = true;
    bonjour = true;
    registerHostname = fqdn;
    registerName = "janastu";
    hostName = "192.168.1.2";
  };

  services.nginx.enable = true;
  services.nginx.virtualHosts.${fqdn} = { globalRedirect = "www.mumble.info"; };

  networking.firewall.allowedTCPPorts = [ config.services.murmur.port ];
  networking.firewall.allowedUDPPorts = [ config.services.murmur.port ];
}

