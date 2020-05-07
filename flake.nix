{
  description = "Janastu packages and configurations";

  edition = 201909;

  inputs.nixpkgs.url = "github:nixos/nixpkgs-channels/nixos-20.03";

  outputs = { self, nixpkgs }: {

    nixosModules.janastu = import ./nixos;

    nixosConfigurations.thinkcentre = nixpkgs.lib.nixosSystem {
      modules = [ ./hosts/thinkcentre ];
      system = "x86_64-linux";
    };

  };
}
