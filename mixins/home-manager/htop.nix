{ config, ...}: {
  programs.htop.enable = true;
  programs.htop.settings = {
    fields = with config.lib.htop.fields; [
      PID STARTTIME M_SHARE M_RESIDENT M_SIZE PERCENT_CPU TIME COMM
    ];

    delay = 10;

    highlight_base_name = 1;
    highlight_megabytes = 1;
    highlight_threads = 1;
    highlight_changes = 1;
    highlight_changes_delay_secs = 1;

    hide_kernel_threads = 1;
    hide_userland_threads = 1;

    show_cpu_usage = 1;
    show_cpu_frequency = 1;
    show_cpu_temperature = 1;

    show_program_path = 0;

    # screen_tabs = 1;

  } // (with config.lib.htop; leftMeters [
    (bar "CPU")
    (bar "Memory")
    (bar "Swap")
    (text "DiskIO")
    (text "NetworkIO")
  ]) // (with config.lib.htop; rightMeters [
    (text "Tasks")
    (text "Systemd")
    (text "LoadAverage")
    (text "PressureStallCPUSome")
    (text "PressureStallIOSome")
  ]);
}
