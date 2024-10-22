{ pkgs, inputs, ...}: let
  user = keys: groups: {
    initialPassword = "changethis";
    extraGroups = [ "wheel" ] ++ groups;
    isNormalUser = true;
    openssh.authorizedKeys.keys = keys;
  };
in {
  users.users = {
    rahul = ( user [
      inputs.rahul-config.resources.pubKeys.rahul
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHa/elqoH3odBlOtHkEyzD8sIm/O+vXKG8F3W1ok6I3c"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAjozJu1DL9jaVz7kQnebiASICum4JaUI9TDB9x5mjNb"
    ] [ "wheel" ]) // { shell = pkgs.bash; };
    jspspike = user [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBQL+zODJ3hrZMYPNtQ+2udF4JY0nNlqGnVth0jir1nI"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJp2dioaz9ppiiCcULqRowIEwQddJe9J1qFYO4p51LT3"
    ] [ "wheel" ];
    jonathan = user [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIET69oniNUA2nJV5+GxQ6XuK+vQbO8Uhtgrp1TrmiXVi"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC0pmCsQeMMJ0r3o/XN7Zw8YFa9OEqrL3ikoGTK0OUY6"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOAXOTU6E06zjK/zkzlSPhTG35PoNRYgTCStEPUYyjeE"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBTqoHEVYxD+mwmZhPj+1+i1P0XmgTxXgSnPdPwFT1vr"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJjE6rvXFX5qr7JGiY7WyXqseMlxSk7M+wyvMAgjIFuD"
    ] [];
    nora = user [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG0n1ikUG9rYqobh7WpAyXrqZqxQoQ2zNJrFPj12gTpP"
    ] [];
    boxy = user [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKOIOhM1xy7x9XY2VBioimjDkqtZI0/paCw1zh3Wjn9Y"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFMNJco+7XH1x91n2rPkOS8Wbq0+Bv6KhWWkacN1y1DR"
    ] [];
    wffl = user [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDr8uWFY5hRTOOeGGUdpROyWVxpkJKp5yJQnivGjY09u"
    ] [];
  };
}
