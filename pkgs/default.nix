self: super: {
  selene = super.callPackage ./selene { };
  jdt-language-server = super.callPackage ./jdt-language-server { };
}
