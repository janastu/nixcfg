{ pkgs, lib, ... }:

let fqdn = "nextcloud.janastu.org";
in {
  services.nextcloud = {
    enable = true;
    hostName = fqdn;
    nginx.enable = true;
    config.adminuser = "admin";
    config.adminpassFile = "/root/nextcloud.pass";
    config.extraTrustedDomains =
      [ "192.168.1.2" "122.166.208.140" ];
  };

  services.nginx.virtualHosts.${fqdn} = {
    addSSL = true;
    enableACME = true;
    default = true;
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
}
