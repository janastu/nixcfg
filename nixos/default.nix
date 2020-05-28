# Entrypoint for Janastu configuration
#

{ config, pkgs, lib, ... }:
with lib;

{
  # Add Janastu options

  options.janastu = {

    syncAudioDirectory = {
      enable = mkEnableOption ''
        Whether to join the Syncthing cluster.
      '';
      path = mkOption {
        type = types.str;
        default = "/srv/audio";
        description = ''
          The path to the folder which should be shared.
        '';
      };
    };

    workstation = {
      enable = mkEnableOption "Whether is a workstation machine";
    };
  };

  # Apply Janastu configuration

  config = let
    cfg = config.janastu;
    mkIfWorkstation = lib.mkIf cfg.workstation.enable;
  in {

    environment.systemPackages = let cfg = config.services.syncthing;
    in mkIf (cfg.enable) [
      cfg.package.icons
      (pkgs.makeDesktopItem {
        name = "net.syncthing.syncthing-gui";
        exec = "xdg-open http://${cfg.guiAddress}";
        icon = "syncthing";
        comment = "Open Syncthing GUI in a web browser";
        desktopName = "Syncthing GUI";
        genericName = "Continuous file synchronization";
        categories = "System;FileTransfer;Monitor;RemoteAccess";
      })
    ];

    fonts = mkIfWorkstation {
      enableDefaultFonts = true;
      fonts = with pkgs;
        let lohit = with builtins; filter isAttrs (attrValues lohit-fonts);
        in lohit ++ [ gubbi-font navilu-font ];
      # Install Kannada fonts
    };

    networking.extraHosts = ''
      200:f7a7:16f2:2940:3aaa:c5e4:270e:3b11 thinkcenter.y
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

    services.syncthing = let cfg = config.janastu.syncAudioDirectory;
    in lib.mkIf cfg.enable {
      enable = true;
      package = pkgs.syncthing.overrideAttrs (attrs: {
        outputs = [ "out" "icons" ];
        postInstall = ''
          for res in 32 64 128 256; do
            install -Dm644 "assets/logo-$res.png" \
              "$icons/share/icons/hicolor/"$res"x"$res"/apps/syncthing.png"
          done
        '';
      });
      group = lib.mkDefault "users";
      declarative.folders.audio = {
        inherit (cfg) path;
        enable = true;
        devices =
          builtins.attrNames config.services.syncthing.declarative.devices;
        # sync the audio folder with all declared devices
      };
      declarative.devices = let transferPort = "22000";
      in {
        thinkcentre = {
          addresses = [
            "tcp://192.168.1.2:${transferPort}"
            "tcp://122.166.208.140:${transferPort}"
            "tcp://[200:f7a7:16f2:2940:3aaa:c5e4:270e:3b11]:${transferPort}"
          ];
          id =
            "D2PSZZB-N7AH2QC-5MGC4QQ-TNVHCXT-VBLUPND-TVHHOA4-QNVD3LM-YC2AHAI";
          introducer = true;
          name = "thinkcentre";
        };
        bigpad.id =
          "OQEGGLY-FG4WZMP-EQ7MYHP-A42CN5F-VLRAR7D-AIF5ESI-SIMNEVI-T2GFDAJ";
        latitude.id =
          "HY4Z34G-7HTOCMU-D6HGD6W-3PIPE5N-VK7VENK-JCZYSMV-IT3CXNA-LC2K4AR";
        "Redmi Note 8 Pro".id =
          "6JF3U6B-BAOVV2K-O2YEBLS-EZYQAMG-R4K6HNS-UTLD36S-TF36GYS-MZEC6Q2";
      };
    };

    system.activationScripts.syncAudioDirectory =
      let cfg = config.janastu.syncAudioDirectory;
      in mkIf cfg.enable ''
        mkdir -p "${cfg.path}"
        chgrp users ${cfg.path}
        chmod g+wrX -R ${cfg.path}
      '';

  };

}
