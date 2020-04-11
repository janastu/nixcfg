{ config, ... }:

let
  pullRequest = builtins.fetchGit {
    url = "https://github.com/otevrenamesta/nixpkgs.git";
    ref = "jitsi-meet";
  };
  prNixpkgs = import pullRequest { };
in {
  imports = let
  in [ "${pullRequest}/nixos/modules/services/web-apps/jitsi-meet.nix" ];

  nixpkgs.overlays = [
    (self: super: { inherit (prNixpkgs) jicofo jitsi-meet jitsi-videobridge; })
  ];

  # security.acme.email = "acme-junk@spam.works";
  # security.acme.acceptTerms = true;

  services.jitsi-meet = {
    enable = true;
    hostName = "jitsi.janastu.org";
    videobridge = {
      openFirewall = true;
      config = {
        "org.jitsi.videobridge.AUTHORIZED_SOURCE_REGEXP" =
          "focus@auth.${config.services.jitsi-meet.hostName}/.*";
        "org.jitsi.videobridge.TCP_HARVESTER_PORT" = "4443";
        "org.jitsi.videobridge.SINGLE_PORT_HARVESTER_PORT" = "10000";
        "org.ice4j.ice.harvest.NAT_HARVESTER_LOCAL_ADDRESS" = "192.168.1.2";
        "org.ice4j.ice.harvest.NAT_HARVESTER_PUBLIC_ADDRESS" =
          "122.166.208.140";
      };
    };
  };

  services.nginx.virtualHosts.${config.services.jitsi-meet.hostName} = {
    default = true; # make this the default virtual host
    enableACME = true;
    forceSSL = true;
    serverAliases = [ "chat.janastu.org" ];
  };
}
