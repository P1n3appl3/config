{
  services = {
    displayManager = {
      cosmic-greeter.enable = true;
      autoLogin = {
        enable = true;
        user = "julia";
      };
    };
    desktopManager.cosmic.enable = true;
    system76-scheduler.enable = true;
  };
}
