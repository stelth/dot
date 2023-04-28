{lib, ...}: {
  i18n = {
    defaultLocale = lib.mkDefault "en_US.UTF-8";
    supportedLocales = ["en_US.UTF-8"];
  };

  services.geoclue2.enable = true;
  services.localtimed.enable = true;
}
