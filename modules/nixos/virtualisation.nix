{pkgs, ...}: {
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu.ovmf.enable = true;
      qemu.swtpm.enable = true;
      #qemuOvmfPackage = pkgs.OVMFFull;
    };
  };

  environment.sessionVariables.LIBVIRT_DEFAULT_URI = ["qemu:///system"];
  environment.systemPackages = with pkgs; [
    virt-manager
    win-virtio
    libvirt
    qemu
    swtpm
  ];
}
