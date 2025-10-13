# Standalone Home Manager Configuration

This directory contains the entry point for a standalone Home Manager configuration that can be deployed on any Linux distribution with the Nix package manager.

## Deployment on non-NixOS

### Prerequisites

1.  **Install Nix:**

    Follow the instructions on the [official NixOS website](https://nixos.org/download.html) to install the Nix package manager on your system.

2.  **Install Home Manager:**

    Add the Home Manager channel and update it:

    ```bash
    nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
    nix-channel --update
    ```

### Installation

1.  **Clone the dotfiles repository:**

    ```bash
    git clone https://github.com/Rishabh5321/dotfiles.git ~/dotfiles
    ```

2.  **Deploy the configuration:**

    Use the following command to build and activate your Home Manager profile:

    ```bash
    nix run home-manager/master -- switch --flake ~/dotfiles#rishabh
    ```

Your dotfiles are now managed by Nix. To update your configuration, simply pull the latest changes from the repository and run the `switch` command again.
