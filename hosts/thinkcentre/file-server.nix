{ config, lib, pkgs, ... }:

let fqdn = "sync.janastu.org";
in {
  services.nginx = {
    enable = true;
    package =
      pkgs.nginx.override { modules = with pkgs.nginxModules; [ fancyindex ]; };
    virtualHosts.${fqdn} = {
      default = true;
      enableACME = true;
      forceSSL = true;
      http2 = true;
      locations = {
        "/" = let
          authFile = pkgs.writeText "htpasswd"
            "janastu:$apr1$jWu4y1NT$KDttnVHakH6IXuHPAFkUv1";
        in {
          alias = "/srv/audio/";
          extraConfig = ''
            auth_basic "Janastu";
            auth_basic_user_file ${authFile};
            fancyindex on;
            # autoindex on;
            dav_access all:r;
          '';
        };
      };
    };
  };

}
