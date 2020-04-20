# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ../../nixos
    ../../nixos/emery.nix
    ../../nixos/dinesh.nix
    ../../nixos/shalini.nix
    ../../nixos/sanketh.nix
    ./jitsi.nix
    ./hardware-configuration.nix
    ./murmur.nix
    ./syncthing.nix
  ];

  nix.distributedBuilds = true;
  nix.buildMachines = [{
    hostName = "192.168.1.6";
    system = "aarch64-linux";
    sshUser = "root";
    sshKey = "/root/.ssh/id_buildfarm";
    maxJobs = 2;
  }];

  environment.variables.NIXOPS_STATE = "/etc/nixops/deployments.nixops";

  nix.package = pkgs.nixFlakes;

  /*
  services.yggdrasil = {
    enable = true;
    openMulticastPort = true;
    config.Peers = [
      "tcp://45.59.126.34:22301" # Singapore
      "tcp://miriam.hrzn.ee:23320" # Singapore
    ];
  };
  */

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [ wget vim nano git rsync ];

  networking.hostName = "thinkcentre"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp0s31f6.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };
  programs.iftop.enable = true;
  programs.mosh.enable = true;
  programs.tmux.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.permitRootLogin = "prohibit-password";

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  #security.acme.acceptTerms = true;
  #security.acme.email = "janastu@servelots.com";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.jane = {
  #   isNormalUser = true;
  #   extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  # };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?

  users.users.airbag = {
    createHome = true;
    extraGroups = [ "users" ];
    home = "/home/airbag";
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILCDMhcAR8e2qPgnEN0DjiZgGveIYU3PiSrZtqj3/LvK user@admin" ];
    useDefaultShell = true;
  };
}
