{
  description = "Janastu packages and configurations";

  edition = 201909;

  outputs = { self }: {

    nixosModules.janastu = import ./nixos;

  };
}
