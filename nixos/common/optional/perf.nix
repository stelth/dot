{config, ...}: {
  environment.systemPackages = [
    config.boot.kernelPackages.perf
  ];
}
