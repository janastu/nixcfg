# Entrypoint for Janastu configuration
#

{ config, pkgs, lib, ... }:

{
  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs;
      let lohit = with builtins; filter isAttrs (attrValues lohit-fonts);
      in lohit ++ [ gubbi-font navilu-font ];
    # Install Kannada fonts
  };

  i18n.defaultLocale = lib.mkDefault "en_IN.UTF-8";

  nix.gc.automatic = lib.mkDefault true;
  # Make regular garbage collections of /nix/store,
  # this is a reasonable default unless you are hacking
  # on packages.

  nixpkgs.overlays = [ (import ../nixpkgs-overlay) ];
  # Add some extra packages not in the NixOS release

  time.timeZone = lib.mkDefault "Asia/Kolkata";
  # Override the default time zone
}
