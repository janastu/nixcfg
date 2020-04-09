{

  latitude = { config, pkgs, ... }: {
    deployment.targetHost = "192.168.1.3";
    imports = [ ./nixos ./hosts/latitude ./nixos/dinesh.nix ];
  };

}
