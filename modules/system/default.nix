{ ... }: {
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
}
