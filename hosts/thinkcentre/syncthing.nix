{ ... }:

{
  services.syncthing = {
    enable = true;
    group = "users";
    guiAddress = "192.168.1.2:8384";
    openDefaultPorts = true;
    declarative.folders."/srv/audio" = {
      enable = true;
      # versioning.type = "staggered";
    };
  };
}
