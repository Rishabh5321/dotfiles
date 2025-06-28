<div align="center">
  <img src="./.github/assets/logo/nixos-logo.png" width="100px" alt="NixOS Logo" />
  <br>
  <h1>Rishabh's Flakes</h1>
  <p>My personal NixOS configurations, managed with Nix Flakes for reproducibility and modularity.</p>
  <p>
    <a href="https://github.com/Rishabh5321/dotfiles">
      <img src="https://img.shields.io/github/repo-size/Rishabh5321/dotfiles?color=B16286&labelColor=282828&style=for-the-badge&logo=github&logoColor=B16286" alt="Repo Size">
    </a>
    <a href="https://nixos.org">
      <img src="https://img.shields.io/badge/NixOS-unstable-blue.svg?style=for-the-badge&labelColor=282828&logo=NixOS&logoColor=458588&color=458588" alt="NixOS Unstable">
    </a>
    <a href="https://github.com/Rishabh5321/dotfiles/blob/main/LICENSE">
      <img src="https://img.shields.io/static/v1.svg?style=for-the-badge&label=License&message=MIT&colorA=282828&colorB=98971A&logo=unlicense&logoColor=98971A&" alt="License: MIT"/>
    </a>
    </a>
     <a href="https://github.com/Rishabh5321/dotfiles/commits/main">
      <img src="https://img.shields.io/github/last-commit/Rishabh5321/dotfiles?color=D65D0E&labelColor=282828&style=for-the-badge&logo=github&logoColor=D65D0E" alt="Last Commit">
    </a>
    <a href="https://github.com/Rishabh5321/dotfiles/actions/workflows/build.yml">
      <img src="https://img.shields.io/github/actions/workflow/status/Rishabh5321/dotfiles/build.yml?branch=main&label=Check%20and%20Build%20Flake%20Config&logo=github&logoColor=98971A&labelColor=282828&style=for-the-badge&color=98971A" alt="Check and Build Flake Config Status">
    </a>
  </p>
  <br>
</div>

## 🖼️ Showcase

<p align="center">
  <img width="80%" src="screenshot/screenshot1.png" />
  <img src="screenshot/screenshot2.png" width="40%" />
  <img src="screenshot/screenshot3.png" width="40%" />
  <img src="screenshot/screenshot4.png" width="40%" />
  <img src="screenshot/screenshot5.png" width="40%" />
</p>

## ✨ Philosophy

This project aims to create a highly modular and reusable NixOS setup for all my machines. The core principles are:

- **Reproducibility:** Nix Flakes ensure that every machine has the exact same configuration, defined declaratively.
- **Modularity:** Configurations are broken down into small, reusable modules (`./modules`) that can be mixed and matched for different hosts.
- **Simplicity:** The structure is designed to be easy to understand and manage, with a clear separation between system-level (`configuration.nix`) and user-level (`home.nix`) settings.
- **Automation:** GitHub Actions are used to automatically check, build, and format the code, ensuring quality and consistency.

## 📂 Directory Structure

The repository is organized to separate concerns, making it easy to manage configurations for different machines and purposes.

```
.
├── containers/   # Nix definitions for containerized services (Plex, Sonarr, etc.)
├── hosts/        # Host-specific configurations. Each subdirectory is a unique machine.
│   └── dell/     # Example host configuration for a machine named 'dell'
│       ├── configuration.nix  # Main NixOS configuration for this host
│       ├── home.nix           # Home Manager configuration for the user on this host
│       └── ...                # Other host-specific files (e.g., hardware-configuration.nix)
├── modules/      # Reusable modules for system and user configurations
│   ├── system/   # System-level modules (boot, networking, security, etc.)
│   └── user/     # Home Manager modules (shell, editors, browsers, etc.)
├── overlays/     # Custom Nixpkgs overlays to modify or add packages
├── pkgs/         # Custom packages built with Nix
├── flake.nix     # The heart of the project, defining inputs and outputs
└── README.md     # This file
```

## 🚀 Usage

### Prerequisites
- A machine with Nix installed, with support for Flakes enabled.
- Git to clone the repository.

### Installation
1.  Clone this repository to your local machine:
    ```bash
    git clone --depth 1 https://github.com/Rishabh5321/dotfiles
    cd dotfiles
    ```

2.  **IMPORTANT**: Before deploying, you **must** create a new host directory under `./hosts/` that matches your machine's hostname. You will also need to generate a `hardware-configuration.nix` specific to your hardware.
    ```bash
    # 1. Get your machine's hostname
    hostname

    # 2. Create a directory for your host
    mkdir -p hosts/$(hostname)

    # 3. Generate a hardware configuration for your new machine
    sudo nixos-generate-config --show-hardware-config > hosts/$(hostname)/hardware-configuration.nix

    # 4. Create your main configuration.nix and home.nix.
    #    You can copy from an existing host to get started.
    cp hosts/dell/configuration.nix hosts/$(hostname)/
    cp hosts/dell/home.nix hosts/$(hostname)/
    ```

3.  Apply the configuration. The flake is set up to automatically detect any directory in `./hosts` as a valid `nixosConfiguration`.
    ```bash
    # Replace <hostname> with your machine's actual hostname
    sudo nixos-rebuild switch --flake .#<hostname>
    ```
    For example, to deploy the `dell` configuration:
    ```bash
    sudo nixos-rebuild switch --flake .#dell
    ```

## flake.nix Details

### Inputs
This flake pulls in several external dependencies to build the system. Key inputs include:
- **nixpkgs**: The primary Nix package set, tracking `nixos-unstable-small`.
- **home-manager**: Manages user-level dotfiles and packages.
- **stylix**: For system-wide theming and styling.
- **sops-nix / agenix**: (Future goal) For managing secrets securely.
- And various other flakes for specific applications and themes.

### Outputs
The flake provides the following outputs:
- **`nixosConfigurations`**: The main output. It dynamically generates a NixOS configuration for every host defined in the `hosts/` directory.
- **`formatter`**: Provides a consistent code formatter (`nixpkgs-fmt`) for the entire project. You can run it with `nix fmt`.
- **`overlays`**: Custom overlays defined in the `overlays/` directory.

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
