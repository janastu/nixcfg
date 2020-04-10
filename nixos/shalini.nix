{ config, pkgs, ... }:

{
  users.users.shalini = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDmxb71mi1j+ekWCvSQ15oLZpvpP3JhD1vH4cv8eRrTcAb0uItr8IHRk7jwnhQ57GI/u6tHWzc3X3Fb0Ia0yCe9VlmWZRj4ipRDDf84NGrazBnTkaxlgzJ+hI85Ts11qCY/5Y9RNp72G0pejAczMZqu5RJTTcLxFAH2sb600rJqnfC5Y1nvAmh7DED9zgNXWdY0ptd09tYEcoFjpXDQBOa8fVH0AavJ7pA57ZyjawGQFOJ3H9PgNuh9XbgFzsxo+aJiF36Hj1QY8UF1ZvC/WcIkZ8MOG0vMmzT313EW2J5cWqYXMLV9mbwFEIL5mQmCjgqba/hivy20uvBt21ocaeCZ janastu@janastu-Latitude-3480"
    ];
  };

}
