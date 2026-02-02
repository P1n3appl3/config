{ pkgs, inputs, ... }: let
  fetchurl = pkgs.fetchurl;
  mods = pkgs.linkFarmFromDrvs "mods" (builtins.attrValues {
    ferrite = fetchurl { url = "https://cdn.modrinth.com/data/uXXizFIs/versions/Ii0gP3D8/ferritecore-8.2.0-fabric.jar"; sha512 = "3210926a82eb32efd9bcebabe2f6c053daf5c4337eebc6d5bacba96d283510afbde646e7e195751de795ec70a2ea44fef77cb54bf22c8e57bb832d6217418869"; };
    lithium = fetchurl { url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/gl30uZvp/lithium-fabric-0.21.2%2Bmc1.21.11.jar"; sha512 = "94625510013e0daaf1c2e2b6d8a463c932ff6220f91ba5b0cd5f868658215f046d94d07b3465660f576c4dc27a5aa183dfbdc1c9303f11894b5b25a1dc6c3bb6"; };
    appleskin = fetchurl { url = "https://cdn.modrinth.com/data/EsAfCjCV/versions/59ti1rvg/appleskin-fabric-mc1.21.11-3.0.8.jar"; sha512 = "d32206cb8d6fac7f0b579f7269203135777283e1639ccb68f8605e9f5469b5b54305fd36ba82c64b48b89ae4f1a38501bfb5827284520c3ec622d95edcfa34de"; };
    krypton = fetchurl { url = "https://cdn.modrinth.com/data/fQEb0iXm/versions/O9LmWYR7/krypton-0.2.10.jar"; sha512 = "4dcd7228d1890ddfc78c99ff284b45f9cf40aae77ef6359308e26d06fa0d938365255696af4cc12d524c46c4886cdcd19268c165a2bf0a2835202fe857da5cab"; };
    c2me = fetchurl { url = "https://cdn.modrinth.com/data/VSNURh3q/versions/olrVZpJd/c2me-fabric-mc1.21.11-0.3.6.0.0.jar"; sha512 = "c9b11100572fb71c3080ff11b011467624e8013b9942aade09a5c77eb62b3289667bad70501ddea8f35deb0a5d26884b79f76d4ed112d32342471ca7384b788a"; };
    distant-horizons = fetchurl { url = "https://cdn.modrinth.com/data/uCdwusMi/versions/GT3Bm3GN/DistantHorizons-2.4.5-b-1.21.11-fabric-neoforge.jar"; sha512 = "a9f673fac1f6f554b7394168cbe726f1a15eb2bbef1b65b3c9979853af8de70bf13a457c88ebdc30b955a071d519e86c631cdbf1dd39cdab7c73b9c2d7f165e1"; };
    scalablelux = fetchurl { url = "https://cdn.modrinth.com/data/Ps1zyz6x/versions/PV9KcrYQ/ScalableLux-0.1.6%2Bfabric.c25518a-all.jar"; sha512 = "729515c1e75cf8d9cd704f12b3487ddb9664cf9928e7b85b12289c8fbbc7ed82d0211e1851375cbd5b385820b4fedbc3f617038fff5e30b302047b0937042ae7"; };
    carpet = fetchurl { url = "https://cdn.modrinth.com/data/TQTTVgYE/versions/HzPcczDK/fabric-carpet-1.21.11-1.4.194%2Bv251223.jar"; sha512 = "1135807e44b34a628c89674a4df94d617120aea932c24c7d4a375410103884e94713b4252d29035d1722d149cc65465afef24eafbfc476c51bc64b6fffff57e0"; };
    fabric-api = fetchurl { url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/L34yYPTD/fabric-api-0.141.2%2B1.21.11.jar"; sha512 = "3c1e7991ae72304a997bdbecc34a4bc742d4601349f000a7d9816b376a2e341c700f519cebb224f565d9b79d9c9492e1d7f918ec3f86e4f363e15df0c07f4b7e"; };
    # syncmatica-revolution = fetchurl { url = "https://cdn.modrinth.com/data/ZFRiWThj/versions/A3d76mQs/syncmatica_r-1.21.11-0.3.18.jar"; sha512 = "5f7de6e9ea5c27f647132f39037991869795bc52556cf805858dc3f5b3aaf01f9a7df9de91d618f0c141e333b450c20cf47a05b692c032499f2cd365ca043ad0"; };
  });
in
{
  imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];
  services.minecraft-servers = { enable = true; eula = true; openFirewall = true; };
  services.minecraft-servers.servers.pineapple = { enable = true;
    package = pkgs.fabricServers.fabric-1_21_11;
    serverProperties = {
      server-port = 25566; # lazymc uses 25565
      difficulty = 3;
      force-gamemode = true;
      white-list = true;
      spawn-protection = 0;
      motd = "Julia's Server";
      max-tick-time = -1;
    };
    # TODO: https://github.com/MeowIce/meowice-flags
    # TODO: use graal instead of jre_headless by overriding lazymc.config.command
    lazymc = {
      enable = true;
    };
    symlinks = { inherit mods; };
    whitelist = {
      "314neapple" = "0e75035d-2631-4bd1-9cf2-6349de192563";
      "iuyag" = "35ed48ab-8fd2-4137-b1fd-b59ed8806d6b";
      "jspspike" = "9c1a5c93-454d-445c-88fd-a226eac44444";
      "Thalie247" = "2a5bac8a-e864-4e32-87f9-1317f4dba4ea";
      "kitkat2306" = "649bce69-7aa0-4f93-8c91-8ec27a10a096";
      "meowjana" = "ae528e39-5a10-40f7-84e9-9d15ddaf7c7d";
      "theLocalChicken" = "8b7dda7e-b989-4d9b-b991-52b50b1e0d44";
      "DevoidOfLife" = "2c749f19-2864-4e7d-ae38-d7181e3223d9";
    };
  };
}
