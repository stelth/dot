{ pkgs, config, home-manager, ... }:
let
  util = (import ./util.nix) { config = config; };
  isDarwin = pkgs.stdenv.isDarwin;

  extraHome = if pkgs.stdenv.isDarwin then {
    "./Library/Application Support/lazygit/config.yml".source = util.link "config/lazygit/config.yml";
    ".hammerspoon".source = util.link "hammerspoon";
  } else {};
in
{
  xdg.configFile = util.link-all "config" ".";

  home.file =
    /* (util.link-all "home" ".") // { */
    {
      ".bashrc".text = "source <(starship init bash --print-full-init)";
      ".zshrc".text = "source <(starship init zsh --print-full-init)";
      ".gitconfig".source = util.link "config/.gitconfig";
      ".ssh".source = util.link "ssh";
      /* "dot".source = util.link ""; */
    } // extraHome // {
      ".npmrc".text = ''
        # auto generated by dot.nix
        global-dir=${config.home.homeDirectory}/.pnpm-global      
      '';
    };

  home.sessionVariables = {
    TERMINFO_DIRS = "${pkgs.kitty.terminfo.outPath}/share/terminfo";
    NIX_GCC = "${pkgs.gcc}/bin/gcc";
  };

  programs.bash = {
    enable = true;
    initExtra = "source <(starship init bash --print-full-init)";
  };

  programs.zsh = {
    enable = true;
    initExtra = "source <(starship init zsh --print-full-init)";
  };
}
