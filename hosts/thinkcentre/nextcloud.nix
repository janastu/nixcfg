{ pkgs, lib, ... }:

{
  services.nextcloud = {
    enable = true;
    hostName = "nextcloud.janastu.org";
    nginx.enable = true;
    config.adminuser = "admin";
    config.adminpassFile = "/root/nextcloud.pass";
    config.extraTrustedDomains =
      [ "192.168.1.2" "122.166.208.140" ];
  };

  services.nginx.virtualHosts."nextcloud.janastu.org" = {
    addSSL = true;
    enableACME = true;
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
}
