{pkgs, ...}: {
  programs.swaylock = {
    package = pkgs.swaylock-effects;
    settings = {
      effect-blur = "20x3";
      fade-in = 0.1;

      font = "Iosevka Nerd Font";
      font-size = 15;

      line-uses-inside = true;
      disable-caps-lock-text = true;
      indicator-caps-lock = true;
      indicator-radius = 40;
      indicator-idle-visible = true;
      indicator-y-position = 1000;

      ring-color = "26233a";
      inside-wrong-color = "eb6f92";
      ring-wrong-color = "eb6f92";
      key-hl-color = "31748f";
      bs-hl-color = "eb6f92";
      ring-ver-color = "f6c177";
      inside-ver-color = "f6c177";
      inside-color = "1f1d2e";
      text-color = "524f67";
      text-clear-color = "1f1d2e";
      text-ver-color = "1f1d2e";
      text-wrong-color = "1f1d2e";
      text-caps-lock-color = "524f67";
      inside-clear-color = "9ccfd8";
      ring-clear-color = "9ccfd8";
      inside-caps-lock-color = "f6c177";
      ring-caps-lock-color = "26233a";
      separator-color = "26233a";
    };
  };
}
