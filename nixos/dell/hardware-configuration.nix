# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config
, lib
, modulesPath
, ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "uas" "usb_storage" "sd_mod" "rtsx_usb_sdmmc" "btrfs" "i915" ];
  #boot.kernelParams = [ "radeon.si_support=0" "amdgpu.si_support=1" "radeon.cik_support=0" "amdgpu.cik_support=1" ];
  boot.initrd.kernelModules = [ ];
  #boot.kernelParams = [ "radeon.runpm=0" "amdgpu.runpm=0" ];
  boot.blacklistedKernelModules = [ "amdgpu" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/0b3bb14a-982f-4982-8585-297dc23545e2";
    fsType = "btrfs";
    options = [ "subvol=@" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/91C1-C24A";
    fsType = "vfat";
    options = [ "fmask=0022" "dmask=0022" ];
  };

  swapDevices = [
    {
      device = "/dev/disk/by-uuid/ef057973-02c6-45a6-96dd-01808bfeda1a";
    }
  ];

  fileSystems."/mnt/Raid" = {
    device = "/dev/disk/by-uuid/603A67F03A67C220";
    fsType = "ntfs";
  };

  fileSystems."/mnt/E_Disk" = {
    device = "/dev/disk/by-uuid/48EC77156D5D3589";
    fsType = "ntfs";
  };

  fileSystems."/mnt/Win_Disk" = {
    device = "/dev/disk/by-uuid/028C281F8C281029";
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

  # systemd.tmpfiles.rules = [
  #   "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  # ];

  # hardware.graphics = {
  #   extraPackages = with pkgs; [
  #     rocmPackages.clr.icd
  #     amdvlk
  #   ];
  #   extraPackages32 = with pkgs; [
  #     driversi686Linux.amdvlk
  #   ];
  # };

  # environment.variables = {
  #   ROC_ENABLE_PRE_VEGA = "1";
  # };

}
