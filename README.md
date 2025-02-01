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


