# Entrypoint for Janastu configuration
#

{ config, pkgs, lib, ... }:

{
  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [ gubbi-font navilu-font ];
    # Install Kannada fonts
  };

  nixpkgs.overlays = [ (import ../nixpkgs-overlay) ];
  # Add some extra packages not in the NixOS release

  time.timeZone = lib.mkDefault "Asia/Kolkata";
  # Override the default time zone
}
