{...}: {
  programs.ssh = {
    enable = true;
    extraConfig = ''
      IdentityAgent "~/.1password/agent.sock"
    '';
  };

  home.persistence = {
    "/persist/home/stelth".directories = [
      ".config/1Password"
      ".local/share/keyrings"
    ];
  };
}
