self: super: {
  nodePackages = super.nodePackages // super.callPackage ./node-packages { };
  selene = super.callPackage ./selene { };
}
