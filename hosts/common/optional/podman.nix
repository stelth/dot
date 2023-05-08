{
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    dockerSocket.enable = true;
    defaultNetwork.settings.dns_enabled = true;
  };

  environment.persistence = {
    "/persist".directories = [
      "/var/lib/containers"
    ];
  };
}
