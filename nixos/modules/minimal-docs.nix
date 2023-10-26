{lib, ...}: {
  documentation = {
    nixos.enable = lib.mkForce false;
    info.enable = false;
    doc.enable = false;
  };
}
