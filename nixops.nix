{
  latitude = { config, pkgs, ... }: {
    deployment.targetHost = "192.168.1.3";
    imports = [ ./nixos ./hosts/latitude ./nixos/dinesh.nix ];
  };

  nixpi = { config, pkgs, ... }: {
    deployment.targetHost = "192.168.1.6";
    nixpkgs.system = "aarch64-linux";
    imports = [ ./nixos ./hosts/nixpi ];
  };

  /* thinkcentre = { config, pkgs, ... }: {
       deployment.targetHost = "127.0.0.1";
       imports = [ ./hosts/thinkcentre ];
     };
  */
}
