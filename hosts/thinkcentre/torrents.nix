{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ transmission-remote-gtk ];
  services.transmission = {
    enable = true;
    home = "/home/janastu";
    settings = {
      rpc-whitelist = "127.0.0.1,192.168.1.*";
      ratio-limit-enabled = true;
    };
    user = "janastu";
  };
}
