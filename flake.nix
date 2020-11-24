{
  description = "Janastu packages and configurations";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/release-20.09";

  outputs = { self, nixpkgs }: {

    nixosModules.janastu = import ./nixos;

    nixosConfigurations.thinkcentre = nixpkgs.lib.nixosSystem {
      modules = [ ./hosts/thinkcentre ];
      system = "x86_64-linux";
    };

  };
}
