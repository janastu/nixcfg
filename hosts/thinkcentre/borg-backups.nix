{ config, ... }:

{
  services.borgbackup.repos.t420 = {
    allowSubRepos = true;
    authorizedKeys = config.users.users.emery.openssh.authorizedKeys.keys;
    path = "/home/backups/emery";
    quota = "96G";
  };
}
