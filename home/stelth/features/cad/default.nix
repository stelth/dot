{pkgs, ...}: {
  home.packages = with pkgs; [freecad];

  home.persistence = {
    "/persist/home/stelth" = {
      directories = [
        ".local/share/FreeCAD"
        ".config/FreeCAD"
        ".cache/FreeCAD"
      ];
    };
  };
}
