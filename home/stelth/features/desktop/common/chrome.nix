{...}: {
  programs.google-chrome = {
    enable = true;
    commandLineArgs = ["--enable-features=OzonePlatform" "--ozone-platform=wayland" "--use-angle=vulkan" "--use-cmd-decoder=passthrough"];
  };

  home = {
    persistence = {
      "/persist/home/stelth".directories = [
        ".config/google-chrome"
      ];
    };
  };
}
