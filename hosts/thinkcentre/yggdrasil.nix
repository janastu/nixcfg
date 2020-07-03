{ ... }:

let
  listenPort = 1194;
  eth0 = "eth0";
in with (import ./yggaddr.nix); {
  boot.kernel.sysctl."net.ipv6.conf.all.forwarding" = 1;

  networking.firewall.allowedTCPPorts = [ listenPort ];

  networking.interfaces = {
    ${eth0}.ipv6.addresses = [{
      address = prefix64 + "::1";
      prefixLength = 64;
    }];
  };

  services.radvd = {
    enable = true;
    config = ''
      interface ${eth0}
      {
        AdvSendAdvert on;
        AdvDefaultLifetime 0;
        prefix ${prefix64}::/64 {
                AdvOnLink on;
                AdvAutonomous on;
                };
        route 200::/8 {};
      };
    '';
  };

  services.yggdrasil = {
    enable = true;
    openMulticastPort = true;
    configFile = "/var/lib/yggdrasil/keys";
    config = {
      # LinkLocalTCPPort = listenPort;
      Listen = [ "tcp://0.0.0.0:${toString listenPort}" ];
      MulticastInterfaces = [ ".*" ];
      NodeInfo = {
        name = "servelots";
        location = "Bengaluru, India";
        peering = "tcp://122.166.208.140:${toString listenPort}";
      };
      Peers = [
        "tcp://176.223.130.120:22632" # Wroclaw - 6,900 km
        "tcp://194.177.21.156:5066" # Moscow - 5,600 km
        "tcp://46.151.26.194:60575" # Moscow - 5,600 km
        "tcp://95.79.97.17:50001" # Nizhniy Novgorod - 5,600 km
        "tcp://45.59.126.34:22301" # Singapore
        "tcp://miriam.hrzn.ee:23320" # Singapore
      ];
    };
  };

}
