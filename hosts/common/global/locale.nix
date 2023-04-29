{lib, ...}: {
  i18n = {
    defaultLocale = lib.mkDefault "en_US.UTF-8";
    supportedLocales = ["en_US.UTF-8/UTF-8"];
  };

  time.timeZone = lib.mkDefault "America/Chicago";

  services.geoclue2.enable = true;
  services.localtimed.enable = true;
}
