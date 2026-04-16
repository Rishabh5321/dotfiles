{ ... }:
{
  imports = [
    # System Core & Boot
    ./core

    # Package Management
    ./packages

    # Hardware
    ./hardware

    # Applications & Software
    ./application

    # Security & Access Control
    ./security

    # Network & Services
    ./network

    # Virtualization & Containers
    ./virtualization

    # Theming & UI
    ./theme
  ];

  documentation.nixos.enable = false;

  system.autoUpgradeOnShutdown = {
    enable = true;
    flake = "github:rishabh5321/dotfiles";
    host = "dankmaterialbook";
    minimumBatteryToProceedWithoutAC = 30;
  };
}
