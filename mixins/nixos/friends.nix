{ pkgs, inputs, ...}: let
  user = name: keys: {
    initialPassword = "changethis";
    extraGroups = [ "wheel" name ];
    isNormalUser = true;
    openssh.authorizedKeys.keys = keys;
  };
in {
  users.users = {
    rahul = ( user "rahul" [
      inputs.rahul-config.resources.pubKeys.rahul
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHa/elqoH3odBlOtHkEyzD8sIm/O+vXKG8F3W1ok6I3c"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAjozJu1DL9jaVz7kQnebiASICum4JaUI9TDB9x5mjNb"
    ]) // { shell = pkgs.bash; };
    jspspike = user "jspspike" [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBQL+zODJ3hrZMYPNtQ+2udF4JY0nNlqGnVth0jir1nI"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJp2dioaz9ppiiCcULqRowIEwQddJe9J1qFYO4p51LT3"
    ];
  };
}
