{...}: {
  programs.google-chrome = {
    enable = true;
    commandLineArgs = [
      "--use-angle=vulkan"
      "--use-cmd-decoder=passthrough"
    ];
  };

  home = {
    persistence = {
      "/persist/home/stelth".directories = [
        ".config/google-chrome"
      ];
    };
  };
}
