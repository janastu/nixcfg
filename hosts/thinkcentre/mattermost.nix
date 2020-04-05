{ config, ... }:

let fqdn = "chat.janastu.org";
in {

  services.mattermost = {
    enable = true;
    listenAddress = "192.168.1.2:8065";
    siteName = "Janastu";
    siteUrl = "https://" + fqdn;
  };

  services.nginx = {
    enable = true;
    virtualHosts.${fqdn} = {
      forceSSL = true;
      enableACME = true;
      locations."/".proxyPass = "http://"
        + config.services.mattermost.listenAddress;
    };
  };

}
