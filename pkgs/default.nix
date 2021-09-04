self: super: {
  nodePackages = super.nodePackages // super.callPackage ./prettierd { };
  selene = super.callPackage ./selene { };
  jdt-language-server = super.callPackage ./jdt-language-server { };
}
