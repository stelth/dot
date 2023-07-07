{pkgs, ...}: {
  home.packages = with pkgs; [
    (nerdfonts.override
      {fonts = ["Iosevka" "FiraCode"];})
  ];
}
