{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    qemu
    swtpm
    libvirt
  ];

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu;
    };
  };
}
