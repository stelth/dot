{ inputs, config, pkgs, ... }:
let
  checkBrew = "command -v brew > /dev/null";
  installBrew = ''
    ${pkgs.bash}/bin/bash -c "$(${pkgs.curl}/bin/curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"'';
in {
  environment = { extraInit = "${checkBrew} || ${installBrew}"; };

  homebrew = {
    enable = true;
    global = { brewfile = true; };
    taps = [
      "beeftornado/rmtree"
      "homebrew/bundle"
      "homebrew/cask"
      "homebrew/cask-fonts"
      "homebrew/cask-versions"
      "homebrew/core"
      "homebrew/services"
      "koekeishiya/formulae"
    ];
    extraConfig = ''
      brew "yabai", restart_service: "changed"
    '';

    brews = [ ];
  };
}
