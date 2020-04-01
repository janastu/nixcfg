{ ... }:

{
  janastu.syncAudioDirectory.enable = true;

  services.syncthing = {
    enable = true;
    group = "users";
    guiAddress = "192.168.1.2:8384";
    openDefaultPorts = true;
  };
}
