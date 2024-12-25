{ username
, pkgs
, host
, ...
}: {
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    ./emoji.nix
    ./hypridle.nix
    ./hyprland.nix
    ./hyprlock.nix
    ./rofi/config-emoji.nix
    ./rofi/config-long.nix
    ./rofi/config-wallpaper.nix
    ./rofi/rofi.nix
    ./swaync.nix
    ./swaync.nix
    ./waybar.nix
    ./wlogout.nix
  ];

  systemd.user.targets.hyprland-session.Unit.Wants = [
    "xdg-desktop-autostart.target"
  ];

  home.file.".config/wlogout/icons" = {
    source = ./wlogout;
  };
  home.file.".config/swappy/config".text = ''
    [Default]
    save_dir=/home/${username}/Pictures/Screenshots
    save_filename_format=screenshot-%Y%m%d-%H%M%S.png
    show_panel=false
    line_size=5
    text_size=20
    text_font=Ubuntu
    paint_mode=brush
    early_exit=true
    fill_shape=false
  '';

  # Create XDG Dirs
  xdg = {
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };

  home.packages = [
    (import ./pkgs/rofi-launcher.nix { inherit pkgs; })
    (import ./pkgs/emopicker9000.nix { inherit pkgs; })
    (import ./pkgs/task-waybar.nix { inherit pkgs; })
    #(import ../pkgs/squirtle.nix {inherit pkgs;})
    #(import ../pkgs/nvidia-offload.nix { inherit pkgs; })
    (import ./pkgs/wallsetter.nix {
      inherit pkgs;
      inherit username;
    })
    (import ./pkgs/web-search.nix { inherit pkgs; })
    (import ./pkgs/rofi-launcher.nix { inherit pkgs; })
    (import ./pkgs/screenshootin.nix { inherit pkgs; })
    (import ./pkgs/list-hypr-bindings.nix {
      inherit pkgs;
      inherit host;
    })
    #(import ../pkgs/startup.nix {inherit pkgs;})
    #(import ../pkgs/battery.nix {inherit pkgs;})
    pkgs.wayland-protocols
    pkgs.wayland-utils
    pkgs.wlr-randr
    pkgs.brightnessctl
    pkgs.kdePackages.kdeconnect-kde
  ];

}
