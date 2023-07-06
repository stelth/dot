{pkgs, ...}: {
  home.packages = with pkgs; [
    (nerdfonts.override
      {fonts = ["Iosevka"];})
    fira-code
  ];
}
