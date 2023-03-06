{...}: {
  programs.git = {
    userEmail = "Jason.P.Cox@ibm.com";
    userName = "Jason Cox";
    extraConfig = {
      http = {sslVerify = true;};
      github = {user = "JasonCoxIBM";};
    };
  };
}
