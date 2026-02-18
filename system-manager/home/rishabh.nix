{ pkgs
, wallpapers
, flakeDir
, lib
, ...
}:

let
  # 1. Define the wrapper here so it's accessible to the activation script below
  waylandWrapper = pkgs.writeShellScriptBin "nix-session-wrapper" ''
    # Source profiles to ensure Nix binaries are in PATH
    [ -f /etc/profile ] && . /etc/profile
    [ -f "$HOME/.profile" ] && . "$HOME/.profile"
    [ -f "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ] && . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"

    export WLR_NO_HARDWARE_CURSORS=1

    # Run the session
    exec "$@"
  '';
in
{
  imports = [
    ./../../modules/user

    ./nix-settings.nix
    ./packages.nix
    ./power.nix
    ./theme.nix
    ./nh.nix
    ./noctalia.nix

    ./../../modules/desktop/Sway-Noctalia/home
  ];

  home.shellAliases = {
    hms = "home-manager switch --flake ${flakeDir} -b bak";
    hmsg = "cd ~/dotfiles && git pull && home-manager switch --flake ${flakeDir} -b bak";
    hmsu = "cd ~/dotfiles && git pull && home-manager switch --flake ${flakeDir} -b bak && sudo pacman -Syu && flatpak update";
  };

  home.file."Pictures/Wallpapers" = {
    source = wallpapers;
    recursive = true;
  };

  home.sessionVariables = {
    XDG_DATA_DIRS = lib.mkForce "$HOME/.nix-profile/share:/nix/var/nix/profiles/system-manager-current/share:$XDG_DATA_DIRS";
    QS_ICON_THEME = "Papirus-Dark";
  };

  home.sessionPath = [
    "/nix/var/nix/profiles/system-manager-current/bin"
  ];

  targets.genericLinux.enable = true;

  home.username = "rishabh";
  home.homeDirectory = "/home/rishabh";

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "26.05";

  home.activation = {
    syncWaylandSessions = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      TARGET_DIR="/usr/share/wayland-sessions"
      NIX_SESSIONS_DIR="$HOME/.nix-profile/share/wayland-sessions"
      SUDO_BIN="/usr/bin/sudo"

      if [ -d "$NIX_SESSIONS_DIR" ]; then
        echo "Syncing Wayland sessions to $TARGET_DIR..."
        $DRY_RUN_CMD $SUDO_BIN mkdir -p "$TARGET_DIR"

        for session_file in "$NIX_SESSIONS_DIR"/*.desktop; do
          filename=$(basename "$session_file")
          temp_file=$(mktemp)
          cp "$session_file" "$temp_file"

          ORIG_EXEC=$(grep -Po '^Exec=\K[^ ]+' "$session_file" | head -n 1)
          sed -i "s|^Exec=.*|Exec=${waylandWrapper}/bin/nix-session-wrapper $ORIG_EXEC|" "$temp_file"

          $DRY_RUN_CMD $SUDO_BIN cp "$temp_file" "$TARGET_DIR/$filename"
          $DRY_RUN_CMD $SUDO_BIN chmod 644 "$TARGET_DIR/$filename"
          rm "$temp_file"
        done

        # --- NEW CLEANUP LOGIC ---
        echo "Cleaning up orphaned Nix sessions from $TARGET_DIR..."
        for installed_session in "$TARGET_DIR"/*.desktop; do
          [ -e "$installed_session" ] || continue

          base_name=$(basename "$installed_session")

          # Only delete if:
          # 1. The file does NOT exist in our current Nix profile
          # 2. The file contains our specific wrapper (safety check)
          if [ ! -f "$NIX_SESSIONS_DIR/$base_name" ]; then
            if grep -q "nix-session-wrapper" "$installed_session"; then
              echo "Removing old Nix session: $base_name"
              $DRY_RUN_CMD $SUDO_BIN rm "$installed_session"
            fi
          fi
        done
      fi
    '';
  };
}
