{ pkgs, ... }: {
  boot = {
    # ===== KERNEL CONFIGURATION =====
    kernelPackages = pkgs.linuxPackages_latest;
    consoleLogLevel = 0;

    # Kernel modules and system controls
    kernel.sysctl = {
      # Needed for some Steam games
      "vm.max_map_count" = 2147483642;
    };

    # Virtual camera support (commented out)
    # kernelModules = [ "v4l2loopback" ];
    # extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];

    # ===== BOOTLOADER CONFIGURATION =====
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
      };
      timeout = 5;
      # Note: For Windows dual-boot with systemd-boot, the Windows Boot Manager
      # files (EFI/Microsoft) must be present in the ESP (/boot).
      # You may need to copy them from the Windows EFI partition.
      grub = {
        enable = false;
        #   devices = [ "nodev" ];
        #   efiSupport = true;
        #   efiInstallAsRemovable = false;
        #   useOSProber = true;
        #
        #   # GRUB theme configuration
        #   darkmatter-theme = {
        #     enable = true;
        #     style = "nixos";
        #     icon = "color";
        #     resolution = "1080p";
        #   };
      };
    };

    # ===== BOOT SPLASH SCREEN =====
    plymouth = {
      enable = true;
      theme = "black_hud";
      themePackages = [ pkgs.adi1090x-plymouth-themes ];
    };

    # ===== TEMPORARY FILESYSTEM =====
    tmp = {
      useTmpfs = false;
      tmpfsSize = "30%";
    };

    # ===== APPLICATION SUPPORT =====
    # AppImage support
    binfmt.registrations.appimage = {
      wrapInterpreterInShell = false;
      interpreter = "${pkgs.appimage-run}/bin/appimage-run";
      recognitionType = "magic";
      offset = 0;
      mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
      magicOrExtension = ''\x7fELF....AI\x02'';
    };
  };

  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # ===== THEME OVERRIDES =====
  stylix = {
    targets = {
      # grub.enable = false;
      plymouth.enable = false;
    };
  };

  # ===== ALTERNATIVE GRUB THEMES (DISABLED) =====
  # distro-grub-themes = {
  #   enable = true;
  #   theme = "nixos";
  # };
}
