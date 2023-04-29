{pkgs, ...}: {
  home.packages = [pkgs.wofi];

  xdg.configFile."wofi/config".text = ''
    image_size=48
    columns=3
    allow_images=true
    insensitive=true

    run-always_parse_args=true
    run-cache_file=/dev/null
    run-exec_search=true
  '';
}
