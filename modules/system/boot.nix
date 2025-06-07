{ pkgs, ... }: {
  boot = {
    # Kernel
    kernelPackages = pkgs.linuxPackages;
    consoleLogLevel = 0;
    # This is for OBS Virtual Cam Support
    # kernelModules = [ "v4l2loopback" ];
    # extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
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
    loader.grub = {
      enable = true;
      devices = [ "nodev" ];
      efiInstallAsRemovable = true;
      efiSupport = true;
      useOSProber = true;
      darkmatter-theme = {
        enable = true;
        style = "nixos";
        icon = "color";
        resolution = "1080p";
      };
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
      theme = "cross_hud";
      themePackages = [ pkgs.adi1090x-plymouth-themes ];
    };
  };
  # distro-grub-themes = {
  #   enable = true;
  #   theme = "nixos";
  # };
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
