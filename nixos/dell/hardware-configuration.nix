# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config
, lib
, modulesPath
, pkgs
, ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "uas" "usb_storage" "sd_mod" "rtsx_usb_sdmmc" "amdgpu" ];
  boot.kernelParams = ["radeon.si_support=0" "amdgpu.si_support=1" "radeon.cik_support=0" "amdgpu.cik_support=1" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/5d9c633e-852b-41e7-af63-c4c78722d6d7";
    fsType = "btrfs";
    options = [ "subvol=@" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/F6B3-0A8A";
    fsType = "vfat";
    options = [ "fmask=0022" "dmask=0022" ];
  };

  # swapDevices = [
  #   {
  #     device = "/dev/disk/by-uuid/88b987f5-e215-4969-b225-0d7f1e5f5510";
  #   }
  # ];

  fileSystems."/mnt/Raid" = {
    device = "/dev/disk/by-uuid/603A67F03A67C220";
    fsType = "ntfs";
  };

  fileSystems."/mnt/E_Disk" = {
    device = "/dev/disk/by-uuid/48EC77156D5D3589";
    fsType = "ntfs";
  };

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp2s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp3s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  #systemd.tmpfiles.rules = [
  #  "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  #];

  hardware.graphics = {
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
    ];
  };

  environment.variables = {
  ROC_ENABLE_PRE_VEGA = "1";
};

}
