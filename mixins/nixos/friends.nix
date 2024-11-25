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
    dropbear = user [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC//xJSUcC6/k8IjKpWpWhd1DwUL71IKUOP6InBPekYDFIbsHP+RZq1WkEfwE6Mn9Sa2a6KmgCl5Fb+9IrQd45RXGOzvQSA4uNvBW8fB4/rUNeg+oOucxROV7Hx8CLFhpxvl534zLKSEUD2oMHquueAdXNQotKUOk93R466Fo8oWDXInZJQVc1TAJ9wgS0n0QmoUsyN6weWLc16JjJtBZlCzu4mQLhFpXMIY8MUSOD1Nu0iSOXBmWOfFlW0MOc0gqbFcoXw0Pveh19SO5zo0JPX8n2cR9U0iZrRotd/6Y/Rx5S0CoyvuzWFUIv+PeusC729MnyLjktCxAeWBthhxN2Gs00DaABThmxvF8QZMEGqSVxuvn/ke5YjxT/RLeXn1B4Ct695WENtZo1HhrZmmA+8UuLfLm7Rhcq6hhqKcUr6P/RgjPyU+Q0LhFyjfz3r7VWrd4gANp90mpipVc5KS8I5Of4Joc91NLIlnul7SMmSQ2Sn9ojbYQc1sZMXyTe6ndAu0sTDtGzekP838ISLG/1bstJ365xz+pWact86J10l/MdYNco+xv9B+aaQfPuwNmx59CeHxdeE3EcERRzYdsdoj9iVJZ3bCFUuY+waGXp5eI23ewPag1SmZ9tAiLFJc3V9J/k66OF2Srhw+f2QjF0WST6KAU94h0KAXkNv018CAQ=="
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC/0J4YxcMLrdIKsfHsaokzysAqg5yzosAu+Ikd53aLrCkEkKZPTv5fftWHr1x/znQ8pDwvUCamNl/AQfFMFLjmjl2y+6kOhF3v+bSpxEuiSKVPKi5azFaGaynerIyJL2j87LP0+jj4WAlR+RukdDihGNDZXui5c+xV6/OpMOVpgivWyVzp5U5x7FL+3rVuo9uHPYmR0orwmucc0ZwOhic5KE9YkFHfN5nCIlQ8v0UePiZgR8j7Wet9xo7sh1Cw0W8wT+WlGoHUGDcT1muIlx3g+2QzFq7jdqHRq2o1ghkjrEzI8lB2OmMbS3fEePwKToAQnR2zFfOHzaQRgrNwh9axYsE1XITNO/FGLOWbCy/OAktB9mccYeDmIS99BqnYafF8oFPC0UqyhS8JPbe9PKJ123+6082QHHelXpsm5SnQmynLMXVgwefv0y40R9SODreswgaHVVUTbq31yxSYBqF1WXSWWznwOi2HJER7lQO8zsNs6BmU+ZFraruJk0EomnM= dropbear@arch"
    ] [];
  };
}
