{ pkgs, inputs, ...}: let
  user = keys: groups: {
    initialPassword = "changethis";
    extraGroups = [ "cute" ] ++ groups;
    isNormalUser = true;
    openssh.authorizedKeys.keys = keys;
  };
in {
  users.groups.cute = {};
  users.users = {
    rahul = ( user [
      inputs.rahul-config.resources.pubKeys.rahul
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHa/elqoH3odBlOtHkEyzD8sIm/O+vXKG8F3W1ok6I3c"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAjozJu1DL9jaVz7kQnebiASICum4JaUI9TDB9x5mjNb"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMHLIww+c/ZszUrnZXn8EEdUFLRr0icq/TJarihnLdMh"
    ] [ "wheel" ]) // { shell = pkgs.bash; };
    jspspike = user [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBQL+zODJ3hrZMYPNtQ+2udF4JY0nNlqGnVth0jir1nI"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJp2dioaz9ppiiCcULqRowIEwQddJe9J1qFYO4p51LT3"
    ] [ "wheel" ];
    jana = user [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIET69oniNUA2nJV5+GxQ6XuK+vQbO8Uhtgrp1TrmiXVi"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOAXOTU6E06zjK/zkzlSPhTG35PoNRYgTCStEPUYyjeE"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBTqoHEVYxD+mwmZhPj+1+i1P0XmgTxXgSnPdPwFT1vr"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJjE6rvXFX5qr7JGiY7WyXqseMlxSk7M+wyvMAgjIFuD"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICgadaDrViJp0Z6fbLBAo9grkmCeNQliIPXe12l3X3i/"
    ] [];
    nora = user [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG0n1ikUG9rYqobh7WpAyXrqZqxQoQ2zNJrFPj12gTpP"
    ] [];
    boxy = user [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKOIOhM1xy7x9XY2VBioimjDkqtZI0/paCw1zh3Wjn9Y"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFMNJco+7XH1x91n2rPkOS8Wbq0+Bv6KhWWkacN1y1DR"
    ] [];
    wffl = user [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEvEDTy6VowQbkzi0dYiq99OQ3/ClIzFgA+n1u8giZyO"
    ] [];
    vivian = user [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA+8Uu2zJEzZYQ3XhYfuu7FZmEci+Ty9r26Z3L+v6TKV"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICBhJAp7NWlHgwDYd2z6VNROy5RkeZHRINFLsFvwT4b3"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIfooZjMWXvXZu1ReOEACDZ0TMb2WJRBSOLlWE8y6fUh"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID+HbsgJTQS6pvnMEI5NPKjIf78z+9A7CTIt3abi+PS6"
    ] [];
    mara = user [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKAzf3UCwTWJlF878EWqlrLUOBsxw/b/6PoLjbKkA8Xh"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIHi5YnRt1VgK8tt6oSPsKo1X+0gcBXVyvCKXM03/vEh"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFWF1MtDV5HJT+GhD8wrKICyDwQK8ZPQTxZdnsfaqWcs"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIHi1EEGRry1aD6uPmdlcRqdiTiIty0JlnfoXeM0qKBC"
    ] [];
    jyn = user [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCq58SNpVf4jk1Vs5W7Ur4yap/9vSyuKSIo+ZmBHtMwt0sRxqlpaCm7SgxOcggyItzCRgjJd4X4fi5MNufDD8HB26YPO7fC6VJha+CccBX+y67xjGxWEJW8ERSnyD5T6Pf+g9kWQCov6IJreKS7tn0j/rH4GW9EVB+T4G7T4b6anmSz49L8AII/rYDYCYcKU+JSl6fQGrliZP12NZJCW9T5nOhqTBEQBnIrTuUeD2Jdb39jloQ4Xob3UPld63ciWWIOWPF/TL4B3ILeAAz5+yljtI0H5jXmLNkN2noOitZp+9hdD/w7gpcn6WQeQV9hQJRwNhvx0xXfZsnsqkn1Qrvd"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC51nwBzsuJaYqpIcK/F/wIGdvduedtz49G4WkuXZfgkbJ2J459cEQlCt5QQsDRG62cTeSh8fSDUX3vDsU+NuqwF5nba1vdjsCiw7SEDCFf9V8BGSR86T8FZcEyqSuaH00wCzKfLu6i4kkjG1y9nhUXLIe4EFJIxuD6ELKU7OoiJphleqDRouSuEbwNC3BL3TZRJsr7NfbA4IT/k4hBXFRZG/Aae2X77mpGigv2D3l2b7y/03AKhAjSyULpWsj/5C9ZVuEYePH8E9JsbeEXoLhfQIj2ZXzWIOsjB4oaCwD1GLkTmw7pdvYvNI/koDCKQfC3Xsl+XakmbVNPhEtNYN8skAggo+In2UTJDtejTHfv17YPbJ57S7EM3/IeOaTFRcnJkC/bAgIwSDK7YAOhrI7DpQgHDy5Fbasc98Wg6iD4zkaIZrSsUwIDVDJdNm5TQCouIIYvT7ucqv9XtYLUEyvbr/96gcTIViZec2aiR+Jd2fBr2DlqWRAA4N36OiJn1uc="
    ] [];
    dropbear = (user [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC//xJSUcC6/k8IjKpWpWhd1DwUL71IKUOP6InBPekYDFIbsHP+RZq1WkEfwE6Mn9Sa2a6KmgCl5Fb+9IrQd45RXGOzvQSA4uNvBW8fB4/rUNeg+oOucxROV7Hx8CLFhpxvl534zLKSEUD2oMHquueAdXNQotKUOk93R466Fo8oWDXInZJQVc1TAJ9wgS0n0QmoUsyN6weWLc16JjJtBZlCzu4mQLhFpXMIY8MUSOD1Nu0iSOXBmWOfFlW0MOc0gqbFcoXw0Pveh19SO5zo0JPX8n2cR9U0iZrRotd/6Y/Rx5S0CoyvuzWFUIv+PeusC729MnyLjktCxAeWBthhxN2Gs00DaABThmxvF8QZMEGqSVxuvn/ke5YjxT/RLeXn1B4Ct695WENtZo1HhrZmmA+8UuLfLm7Rhcq6hhqKcUr6P/RgjPyU+Q0LhFyjfz3r7VWrd4gANp90mpipVc5KS8I5Of4Joc91NLIlnul7SMmSQ2Sn9ojbYQc1sZMXyTe6ndAu0sTDtGzekP838ISLG/1bstJ365xz+pWact86J10l/MdYNco+xv9B+aaQfPuwNmx59CeHxdeE3EcERRzYdsdoj9iVJZ3bCFUuY+waGXp5eI23ewPag1SmZ9tAiLFJc3V9J/k66OF2Srhw+f2QjF0WST6KAU94h0KAXkNv018CAQ=="
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC/0J4YxcMLrdIKsfHsaokzysAqg5yzosAu+Ikd53aLrCkEkKZPTv5fftWHr1x/znQ8pDwvUCamNl/AQfFMFLjmjl2y+6kOhF3v+bSpxEuiSKVPKi5azFaGaynerIyJL2j87LP0+jj4WAlR+RukdDihGNDZXui5c+xV6/OpMOVpgivWyVzp5U5x7FL+3rVuo9uHPYmR0orwmucc0ZwOhic5KE9YkFHfN5nCIlQ8v0UePiZgR8j7Wet9xo7sh1Cw0W8wT+WlGoHUGDcT1muIlx3g+2QzFq7jdqHRq2o1ghkjrEzI8lB2OmMbS3fEePwKToAQnR2zFfOHzaQRgrNwh9axYsE1XITNO/FGLOWbCy/OAktB9mccYeDmIS99BqnYafF8oFPC0UqyhS8JPbe9PKJ123+6082QHHelXpsm5SnQmynLMXVgwefv0y40R9SODreswgaHVVUTbq31yxSYBqF1WXSWWznwOi2HJER7lQO8zsNs6BmU+ZFraruJk0EomnM= dropbear@arch"
    ] []) // { shell = pkgs.bash; } ;
    cdruid = (user [
      "ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1MjEAAACFBAGuyes0oNZO+LWvjx6JnPMth7nFwUDg4MoJs5Q00uZAEwjC+eAkk3SxAAiyORaRD250ASjJ/ArZWUQ7IZENcHBEVQGWaCWuw06Rr2f4KVNmnPzPFKpd91QxyBd3EXXScpDeOKGF/yB1GCMkNN52StVEllhiz/eorAXFo4d0bzlRxNivBg=="
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG0im7/KNw4pgeH3RzgQaJeVFekbqXjDj+HYPqVbSFXv"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH8dZcQILx0u2efLceHWaXzulOsu9rHO1xeGT5SLeNWc"
    ] []) // { shell = pkgs.fish; };
    yaah = (user [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBvDoWAmF3JupYvTTSSA084bPdmYWUrIlK66r9QL2JlD"
    ] []);
  };
}
