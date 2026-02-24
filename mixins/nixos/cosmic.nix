{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    wev wl-clipboard grim slurp hyprpicker wlprop
  ];

  services = {
    displayManager = {
      cosmic-greeter.enable = true;
      autoLogin = { enable = true; user = "julia"; };
    };
    desktopManager.cosmic.enable = true;
    system76-scheduler.enable = true;
  };
}
