{ config, pkgs, ... }:

let
  keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICgL2kRs+cXAcUzOO2Tp+mtMBVuHqMuslQy3LN+HLSP4 emery@nixos"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDnFa8p+KnOPSSqdPr6yvFcULgSM/QHzEO8TradwiW59 emergency"
  ];
in {

  nix.trustedUsers = [ "emery" ];

  programs = {
    fish.enable = true;
    tmux = {
      enable = true;
      secureSocket = true;
    };
  };

  users.users.emery = {
    isNormalUser = true;
    description = "Emery";
    extraGroups = [ "users" "wheel" ];
    hashedPassword =
      "$6$ZgiLSFCQPW0DB0i$aPeZ9E62y2OvqRbNAEL.8IK30YgvyLy6UOitN6A.li.YmUrmYAh1ukB844MFp3KlTpYzi5e80hRIg1Vx1F0uO/";
    uid = 1000;
    openssh.authorizedKeys = { inherit keys; };
    shell = pkgs.fish;
  };

  users.users.root.openssh = {
    inherit (config.users.users.emery.openssh) authorizedKeys;
  };

}
