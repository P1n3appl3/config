{ pkgs, inputs, ... }: let
  inherit (inputs.nix-minecraft.lib) collectFilesAt;
  modpack = pkgs.fetchPackwizModpack {
    url = "https://github.com/p1n3appl3/mc-mods/";
    packHash = "";
  };
in
{
  imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];
  services.minecraft-servers = { enable = true; eula = true; openFirewall = true; };
  services.minecraft-servers.servers.pineapple = { enable = true;
    package = pkgs.fabricServers.fabric-1_21_11;
    serverProperties = {
      difficulty = 3;
      force-gamemode = true;
      white-list = true;
      motd = (let
        esc=''\u00A79'';
        reset="${esc}r";
        bold="${esc}l";
        white="${esc}f";
        cyan="${esc}b";
        pink="${esc}d";
        in "${bold}${cyan}Jul${pink}ia${white}'s${reset} ${white}S${pink}er${cyan}ver");
      max-tick-time = -1;
    };
    # TODO: https://github.com/MeowIce/meowice-flags
    # TODO: use graal instead of jre_headless by overriding lazymc.config.command
    lazymc.enable = true;
    symlinks = collectFilesAt modpack "mods";
    files = collectFilesAt modpack "config" // {
      "config/server-specific.conf".value = {
        example = "foo-bar";
      };
    };
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
