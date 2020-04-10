{ config, pkgs, ... }:

{
  users.users.sanketh = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJf4rDYBAYoAjWEL9SQL7yTZW9yPQJ/ZOGb66VlEuuzr"
    ];
  };

}
