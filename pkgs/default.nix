self: super: {
  nodePackages = super.nodePackages // super.callPackage ./prettierd { };
  selene = super.callPackage ./selene { };
}
