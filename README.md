# NixOS Configuration for Laptop and Server

This repository contains the NixOS configuration for both a laptop and a server. The configuration is managed using Nix flakes, which allows for reproducible and declarative system setups.

## Table of Contents

- [Overview](#overview)
- [Inputs](#inputs)
- [Outputs](#outputs)
  - [Packages](#packages)
  - [Formatter](#formatter)
  - [Overlays](#overlays)
  - [NixOS Configurations](#nixos-configurations)
- [Usage](#usage)
- [Configuration Details](#configuration-details)
  - [Common Configuration](#common-configuration)
  - [Host-Specific Configuration](#host-specific-configuration)
- [Dependencies](#dependencies)
- [Screenshots](#screenshots)
- [License](#license)

## Overview

This configuration is designed to be modular and reusable across different machines. It includes settings for both system-wide configurations and user-specific home-manager configurations. The setup leverages various NixOS modules and community contributions to enhance functionality and aesthetics.

## Inputs

The following inputs are used in this configuration:

- `nixpkgs`: The main NixOS package repository (unstable branch).
- `nixpkgs-stable`: The stable branch of the NixOS package repository.
- `home-manager`: Manages user environments using Nix.
- `stylix`: Provides theming and styling for NixOS.
- `spicetify-nix`: Customizes Spotify with themes and extensions.
- `alejandra`: A Nix code formatter.
- `zen-browser`: A minimalistic browser configuration.
- `fine-cmdline`: A Neovim plugin for command-line interfaces.
- `nix-flatpak`: Integrates Flatpak applications with NixOS.
- `darkmatter-grub-theme`: A GRUB theme for a dark aesthetic.
- `nix-gaming`: Optimizations and packages for gaming on NixOS.

## Outputs

### Packages

Packages are defined for all supported systems (`x86_64-linux`). These packages can be imported and used within the NixOS configurations.

### Formatter

The formatter used in this configuration is `alejandra`, which ensures consistent code style across the Nix expressions.

### Overlays

Custom overlays are defined to extend or modify the NixOS package set. These overlays are imported from the `./overlays` directory.

### NixOS Configurations

Two NixOS configurations are defined:

- **redmi**: Configuration for a Redmi laptop.
- **dell**: Configuration for a Dell server.

Each configuration includes system-wide settings, theming, and user-specific configurations managed by `home-manager`.

## Usage

To use this configuration, clone the repository and navigate to the desired host configuration:


  ```bash
  git clone https://github.com/Rishabh5321/dotfiles
  cd dotfiles
  ```

Apply the configuration to a specific host:
  ```bash
  sudo nixos-rebuild switch --flake .#redmi
  ```

Replace redmi with dell for the server configuration.

## Configuration Details

## Common Configuration

The `commonConfig` function generates a common set of configurations for all hosts. It includes:

- Special arguments passed to modules.
- System-wide modules like `stylix`, `nix-flatpak`, and `home-manager`.
- User-specific configurations managed by `home-manager`.

## Host-Specific Configuration

Each host has its own directory under `./nixos/<hostname>`, containing:

- `configuration.nix`: System-wide configuration.
- `home.nix`: User-specific configuration managed by `home-manager`.

## Dependencies

This configuration relies on several external inputs and modules. Ensure that all dependencies are available and properly configured before applying the configuration.

## Screenshots

Here are some screenshots of the system in action:

![Screenshot 1](screenshot/screenshot1.png)  
*Desktop environment with custom theming.*

![Screenshot 2](screenshot/screenshot2.png)  
*Home-manager configuration for user-specific settings.*

![Screenshot 3](screenshot/screenshot3.png)  
*Terminal Theme.*

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

For more information on NixOS and home-manager, refer to the official documentation:

- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)
