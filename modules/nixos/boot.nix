{ pkgs, ... }: {
  boot = {
    # Kernel
    kernelPackages = pkgs.linuxPackages_latest;
    consoleLogLevel = 0;
    # This is for OBS Virtual Cam Support
    #kernelModules = [ "v4l2loopback" ];
    #extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
    # Needed For Some Steam Games
    #kernel.sysctl = {
    #  "vm.max_map_count" = 2147483642;
    #};
    # Bootloader.
    loader.grub.enable = true;
    loader.grub.devices = [ "nodev" ];
    loader.grub.efiInstallAsRemovable = true;
    loader.grub.efiSupport = true;
    loader.grub.useOSProber = true;
    #loader.grub.version = 2;
    # Make /tmp a tmpfs
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
      theme = "colorful_loop";
      themePackages = [ pkgs.adi1090x-plymouth-themes ];
    };
    #plymouth.enable = true;
  };
  #Uncomment after enabling stylix
  stylix.targets.grub.enable = false;
  stylix.targets.plymouth.enable = false;
  boot.loader.grub = {
    darkmatter-theme = {
      enable = true;
      style = "nixos";
      icon = "color";
    };
  };
  # Theme names can be
  # 1. tela , 2.vimix , 3.stylish , 4. whitesur

  # boot.loader.grub2-theme = {
  #   enable = true;
  #   theme = "whitesur";
  #   footer = true;
  # };

  # boot.loader.grub.theme = pkgs.stdenv.mkDerivation {
  #   pname = "distro-grub-themes";
  #   version = "3.1";
  #   src = pkgs.fetchFromGitHub {
  #     owner = "AdisonCavani";
  #     repo = "distro-grub-themes";
  #     rev = "v3.1";
  #     hash = "sha256-ZcoGbbOMDDwjLhsvs77C7G7vINQnprdfI37a9ccrmPs=";
  #   };
  #   installPhase = "cp -r customize/nixos $out";
  # };
}
