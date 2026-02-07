{ pkgs
, wallpapers
, wallpaper
, flakeDir
, lib
, config
, inputs
, ...
}:

{
  imports = [
    # ./../modules/user/development/git.nix
    ./../modules/desktop/Sway-Noctalia/home

    ./../modules/user/development/lazygit.nix
    ./../modules/user/files
    ./../modules/user/monitor
    ./../modules/user/shells
    ./../modules/user/shells/oh-my-posh.nix
    ./../modules/user/terminal
    ./../modules/user/utilities/atuin.nix
    ./../modules/user/utilities/tealdeer.nix
    ./../modules/user/utilities/zoxide.nix

    ./nix-settings.nix
    ./noctalia.nix
    ./packages.nix
    ./power.nix
    ./theme.nix
  ];

  home.shellAliases = {
    hms = "home-manager switch --flake ${flakeDir} -b bak";
  };

  home.file."Pictures/Wallpapers" = {
    source = wallpapers;
    recursive = true;
  };

  home.sessionVariables = {
    XDG_DATA_DIRS = lib.mkForce "$HOME/.nix-profile/share:$XDG_DATA_DIRS";
    QS_ICON_THEME = "Papirus-Dark";
  };

  targets.genericLinux.enable = true;

  # Set your username
  home.username = "rishabh";
  home.homeDirectory = "/home/rishabh";

  # Nicely reload system units
  systemd.user.startServices = "sd-switch";

  # Set the state version
  home.stateVersion = "26.05";

  home.activation = {
    syncWaylandSessions = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      TARGET_DIR="/usr/share/wayland-sessions"
      NIX_SESSIONS_DIR="$HOME/.nix-profile/share/wayland-sessions"
      SUDO="/usr/bin/sudo"

      if [ -d "$NIX_SESSIONS_DIR" ]; then
          # 1. Ensure the system directory exists
          $SUDO mkdir -p "$TARGET_DIR"

          for session_file in "$NIX_SESSIONS_DIR"/*.desktop; do
              filename=$(basename "$session_file")
              wm_name=''${filename%.desktop} # Extracts 'sway' or 'hyprland'
              TEMP_FILE="/tmp/$filename"
              cp "$session_file" "$TEMP_FILE"

              # 2. Dynamically find the binary path in the Nix store
              BIN_NAME=$(grep -Po '^Exec=\K[^ ]+' "$session_file" | head -n 1)
              FULL_PATH=$(${pkgs.coreutils}/bin/readlink -f $(${pkgs.which}/bin/which "$BIN_NAME" 2>/dev/null) || echo "$BIN_NAME")

              # 3. Apply the Environment Wrapper
              # This works for any WM by sourcing your profile and setting the correct XDG variables
              sed -i "s|^Exec=.*|Exec=bash -c 'source /etc/profile; source \$HOME/.profile; export XDG_CURRENT_DESKTOP=$wm_name; export XDG_SESSION_DESKTOP=$wm_name; export WLR_NO_HARDWARE_CURSORS=1; exec $FULL_PATH'|" "$TEMP_FILE"

              echo "Syncing $filename with dynamic environment wrapper to GDM..."
              $SUDO cp "$TEMP_FILE" "$TARGET_DIR/$filename"
              $SUDO chmod 644 "$TARGET_DIR/$filename"
          done
      fi

      # 4. Cleanup orphaned links (optional but recommended)
      # Removes links in /usr/share/wayland-sessions that no longer exist in your Nix profile
      for link in "$TARGET_DIR"/*.desktop; do
          if [ -L "$link" ] || [ -f "$link" ]; then
              base=$(basename "$link")
              if [ ! -f "$NIX_SESSIONS_DIR/$base" ] && [[ "$(grep "Nix" "$link")" ]]; then
                   echo "Cleaning up old session: $base"
                   $SUDO rm "$link"
              fi
          fi
      done
    '';
  };
}
