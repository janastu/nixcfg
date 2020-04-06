{ config, pkgs, ... }:

{
  users.users.tbdinesh = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    hashedPassword =
      "$6$lmTrFx4JjDMqH6Qj$5zCi7BxqjOInejkpuOpzu5bQq8tvQ6ZGAofnty9lZ760rOaJfoKiKpFGkCDXe8zctfUo6xdqFafDNQbKrEt56/";
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDNLfVOIjS143ZQtD6SL+RkTeyQ16bjs6QrlPBCFlC+BD7a9n8u7QxLJS5l5/Akq4HGJ62Jl5yl0e+PvqnxeSISxTTLd9uBMfJ4/aQm2exDbXdvrwoF2/c+2doUKyxxWxjbFvscHnDKeIoL0gbFHeMcXXZ48nUdhH15yQUgMdp+5weMiv1b6xS1KVJOVlxtII7jSGe8S27xCU5wuqxFLpAkyCMv43EvsO8QsDVmY3ShJS4Z6Knbso3khKar4zBHD75Io8+YumhzMhUUa9orOn1fEzOiXWQ99+p/pbnSfM0SnOv2YIW/suO/zUUGb396aofZbyod0C1EflUTqiPzzt39 tbdinesh@tbd"
    ];
  };

}
