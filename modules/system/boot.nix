{ pkgs, ... }: {
  boot = {
    # Kernel
    kernelPackages = pkgs.linuxPackages_latest;
    consoleLogLevel = 0;
    # This is for OBS Virtual Cam Support
    kernelModules = [ "v4l2loopback" ];
    extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
    # Needed For Some Steam Games
    kernel.sysctl = {
      "vm.max_map_count" = 2147483642;
    };
    # Bootloader.
    # loader.grub.enable = true;
    # loader.grub.devices = [ "nodev" ];
    # loader.grub.efiInstallAsRemovable = true;
    # loader.grub.efiSupport = true;
    # loader.grub.useOSProber = true;
    loader = {
      grub.enable = true;
      grub.devices = [ "nodev" ];
      grub.efiInstallAsRemovable = true;
      grub.efiSupport = true;
      grub.useOSProber = true;
    };
    tmp = {
      useTmpfs = false;
      tmpfsSize = "30%";
    };
    # Appimage Support
    binfmt.registrations.appimage = {
      wrapInterpreterInShell = false;
      interpreter = "${pkgs.appimage-run}/bin/appimage-run";
      recognitionType = "magic";
      offset = 0;
      mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
      magicOrExtension = ''\x7fELF....AI\x02'';
    };
    plymouth = {
      enable = true;
      theme = "cuts";
      themePackages = [ pkgs.adi1090x-plymouth-themes ];
    };
  };
  distro-grub-themes = {
    enable = true;
    theme = "nixos";
  };
  stylix = {
    targets = {
      grub = {
        enable = false;
      };
      plymouth = {
        enable = false;
      };
    };
  };
}
