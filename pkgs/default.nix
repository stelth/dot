self: super: {
  nodePackages = super.nodePackages // super.callPackage ./prettierd { };
  jdt-language-server = super.callPackage ./jdt-language-server { };
}
