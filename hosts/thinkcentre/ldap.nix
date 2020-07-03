{ config, ... }:
let ygg = import ./yggaddr.nix;
in {
  services.openldap = {
    enable = true;
    rootdn = "cn=admin,dc=janastu,dc=org";
    suffix = "dc=janastu,dc=org";
    rootpwFile = "/etc/openldap.password";
    urlList = [ "ldap://[${ygg.addr}]" ];
    declarativeContents = ''
      dn: dc=janastu,dc=org
      dc: janastu
      o: Janastu
      objectClass: dcObject
      objectClass: organization

      dn: ou=Hosts,dc=janastu,dc=org
      objectClass: organizationalUnit
      objectClass: top
      ou: Hosts

      dn: cn=${config.networking.hostName}+ipHostNumber=${ygg.addr},ou=Hosts,dc=janastu,dc=org
      objectClass: ipHost
      objectClass: device
      objectClass: top
      cn: ${config.networking.hostName}
      ipHostNumber: ${ygg.addr}

    '';
  };
}
