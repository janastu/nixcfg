# Entrypoint for Janastu configuration
#

{ config, pkgs, lib, ... }:
with lib;

{
  # Add Janastu options

  options.janastu.workstation = {
    enable = mkEnableOption "Whether is a workstation machine";
  };

  # Apply Janastu configuration

  config = let
    cfg = config.janastu;
    mkIfWorkstation = lib.mkIf cfg.workstation.enable;
  in {

    fonts = mkIfWorkstation {
      enableDefaultFonts = true;
      fonts = with pkgs;
        let lohit = with builtins; filter isAttrs (attrValues lohit-fonts);
        in lohit ++ [ gubbi-font navilu-font ];
      # Install Kannada fonts
    };

    networking.extraHosts = ''
      205:fe6c:567e:cb71:e831:68ae:4a95:fd2e jitsi.janastu.y
      205:fe6c:567e:cb71:e831:68ae:4a95:fd2e nextcloud.janastu.y
    '';

    nix.gc.automatic = lib.mkDefault true;
    # Make regular garbage collections of /nix/store,
    # this is a reasonable default unless you are hacking
    # on packages.

    nixpkgs.overlays = [ (import ../nixpkgs-overlay) ];
    # Add some extra packages not in the NixOS release

    i18n.defaultLocale = lib.mkDefault "en_IN.UTF-8";

    time.timeZone = lib.mkDefault "Asia/Kolkata";
    # Override the default time zone

    services.avahi = mkDefault {
      # Enable mDNS (.local resolution)
      enable = true;
      nssmdns = true;
      publish = {
        enable = true;
        addresses = true;
        workstation = cfg.workstation.enable;
      };
    };

  };

}
