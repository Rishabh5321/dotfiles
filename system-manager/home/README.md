# Standalone Home Manager Setup Guide

This document outlines the procedure for installing the Nix package manager, deploying a standalone Home Manager configuration, and integrating system-level optimizations for a seamless hybrid environment.

---

## 1. Nix Installation & Initial Config

Install the Nix package manager using the **Determinate Systems** installer. This provides a modern, robust setup with Flakes enabled by default.

* **Install Nix:**
    ```bash
    curl --proto '=https' --tlsv1.2 -sSf -L [https://install.determinate.systems/nix](https://install.determinate.systems/nix) | sh -s -- install
    ```
* **Configure Trusted Users:**
    To allow Home Manager to communicate with the Nix daemon, you must grant your user trusted status.
    ```bash
    # Edit the custom nix configuration
    sudo micro /etc/nix/nix.custom.conf
    ```

    ```bash
    # Add the following line:
    trusted-users = root rishabh
    ```

---

## 2. Deploy Home Manager

Apply your configuration via Nix Flakes. The `-b bak` flag ensures that any existing files in your home directory are backed up rather than causing a collision.

```bash
# Apply the flake
nix run github:nix-community/home-manager -- switch --flake .#rishabh -b bak

# Update your shell to Zsh (if managed by Home Manager)
chsh -s $(which zsh)
```

## 3. Storage Integration (Bind Mounts)

To bridge data between a NixOS partition and your current host, use Bind Mounts. This keeps your heavy data (Documents, Games, etc.) accessible without duplicating files.

  **Edit fstab: sudo micro /etc/fstab**


  ```bash
      /mnt/nixos/home/rishabh/Documents    /home/rishabh/Documents    none    bind,defaults,nofail    0    0
      /mnt/nixos/home/rishabh/Downloads    /home/rishabh/Downloads    none    bind,defaults,nofail    0    0
      /mnt/nixos/home/rishabh/Pictures     /home/rishabh/Pictures     none    bind,defaults,nofail    0    0
      /mnt/nixos/home/rishabh/Videos       /home/rishabh/Videos       none    bind,defaults,nofail    0    0
      /mnt/nixos/home/rishabh/Music        /home/rishabh/Music        none    bind,defaults,nofail    0    0
      /mnt/nixos/home/rishabh/Games        /home/rishabh/Games        none    bind,defaults,nofail    0    0
  ```
## 4. Memory Optimization (zRAM)
  
For 8GB systems, zram-generator provides a compressed swap space in RAM, significantly improving multitasking performance over traditional disk swap.
  
  Install: 
  `` sudo pacman -S zram-generator ``
  
  **Configure: `` sudo micro /etc/systemd/zram-generator.conf ``**
  
  ```bash
      [zram0]
      zram-size = ram / 1
      compression-algorithm = zstd
      swap-priority = 100
      fs-type = swap
  ```
  
  Activate: 
  ```bash 
    sudo systemctl daemon-reload 
    sudo systemctl start /dev/zram0
  ```

## 5. System Hardening & Fixes

A. PAM/Polkit Fix (Auth Wrappers)

Standalone Home Manager cannot easily manage setuid binaries. This fix allows tools like swaylock or sudo prompts to access the host's authentication mechanism.

  Create Tmpfile: ``sudo micro /etc/tmpfiles.d/polkit-fix.conf``
  
  Plaintext

  ```bash 
  # Type Path                   Mode UID  GID  Age Argument
  d    /run/wrappers/bin        0755 root root -   -
  L+   /run/wrappers/bin/unix_chkpwd -    -    -   -   /usr/bin/unix_chkpwd
  ```

  Apply: ``sudo systemd-tmpfiles --create /etc/tmpfiles.d/polkit-fix.conf``

B. Power Management Rules

Trigger Home Manager user-services automatically based on AC power status.

Rule Path: ``/etc/udev/rules.d/99-home-manager-power.rules``

  ```bash
      # AC Plugged In
      ACTION=="change", SUBSYSTEM=="power_supply", KERNEL=="ADP1", ENV{POWER_SUPPLY_ONLINE}=="1", RUN+="/usr/bin/su rishabh -c 'XDG_RUNTIME_DIR=/run/user/1000 systemctl --user start power-plugged.service'"
      
      # AC Unplugged
      ACTION=="change", SUBSYSTEM=="power_supply", KERNEL=="ADP1", ENV{POWER_SUPPLY_ONLINE}=="0", RUN+="/usr/bin/su rishabh -c 'XDG_RUNTIME_DIR=/run/user/1000 systemctl --user start power-unplugged.service'"
  ```
  
Reload Rules: ``sudo udevadm control --reload-rules && sudo udevadm trigger``

## 6. Finalization

Ensure the bootloader is aware of BTRFS snapshots (if applicable):

  ```bash
    sudo refind-btrfs install
  ```
  
Setup Complete.
