let
  me = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPCatP3klEjfQPSiJNUc3FRDdz927BG1IzektpouzOZR";
in builtins.listToAttrs
  (builtins.map (f: { name = f; value.publicKeys = [ me ]; }) [
  "weather.age"
  "porkbun-secret.age"
  "porkbun-api.age"
  "nix-conf.age"
])
