{ lib, inputs, ... }: {
  imports = [
    "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  home-manager.users.julia.imports = [
    ../mixins/home/common.nix
    { home.sessionVariables.CONF_DIR = inputs.self.outPath; }
  ];

  services.getty.autologinUser = lib.mkForce "julia";
}
