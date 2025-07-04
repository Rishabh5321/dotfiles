# NixOS ISO

This directory contains the configuration for a bootable NixOS ISO.

## Building the ISO

To build the ISO, run the following command from the root of your dotfiles repository:

```bash
nix build .#iso
```

The resulting ISO image will be in the `result/iso/` directory.

## Installing the ISO

You can write the ISO to a USB drive using `dd`:

```bash
sudo dd if=result/iso/nixos-*.iso of=/dev/sdX bs=4M status=progress oflag=sync
```

Replace `/dev/sdX` with the appropriate device name for your USB drive.

After booting from the USB drive, you can partition the disk and then install your NixOS configuration.

### Partitioning the Disk

You can use a tool like `gdisk` or `parted` to partition your disk. For example, to create a new GPT partition table and two partitions (one for boot and one for the root filesystem), you can use `gdisk`:

```bash
sudo gdisk /dev/sdX
```

Follow the prompts to create a new GPT, an EFI system partition (at least 512M), and a root partition with the remaining space.

### Formatting the Partitions

Format the EFI partition as FAT32 and the root partition as ext4:

```bash
sudo mkfs.fat -F 32 /dev/sdX1
sudo mkfs.ext4 /dev/sdX2
```

### Mounting the Filesystems

Mount the root partition and the boot partition:

```bash
sudo mount /dev/sdX2 /mnt
sudo mkdir -p /mnt/boot
sudo mount /dev/sdX1 /mnt/boot
```

### Generating Hardware Configuration

Now, generate a NixOS configuration file that includes the hardware-specific settings for your new system.

```bash
sudo nixos-generate-config --root /mnt
```

This command will create `hardware-configuration.nix` and `configuration.nix` in `/mnt/etc/nixos/`. We are only interested in the `hardware-configuration.nix` file.

### Cloning your Dotfiles

Before you can install your configuration, you need to clone your dotfiles repository.

```bash
git clone https://github.com/Rishabh5321/dotfiles.git /mnt/root/dotfiles
```

### Preparing the Flake

Copy the generated hardware configuration to the correct host directory in your cloned flake. For example, if you are setting up a new machine to be the `dell` host:

```bash
sudo cp /mnt/etc/nixos/hardware-configuration.nix /mnt/root/dotfiles/hosts/dell/hardware-configuration.nix
```

### Installing NixOS

Now you can install your NixOS configuration using the `nixos-install` command. You will need to specify the flake and the host configuration you want to install. For example, to install the `dell` host configuration:

```bash
sudo nixos-install --flake /mnt/root/dotfiles#dell
```

After the installation is complete, you can reboot into your new NixOS system.
