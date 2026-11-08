{ pkgs, config, lib, ... }:

let
  stylixEnabled = config ? stylix && config.stylix.enable;
  # The greeter only sees NixOS-level packages, not Home Manager ones,
  # so the cursor theme must exist system-wide (see environment.systemPackages below).
  cursorTheme = if stylixEnabled then config.stylix.cursor.name else "capitaine-cursors";
  cursorSize = if stylixEnabled then config.stylix.cursor.size else 16;
in
{

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "sddm-astronaut-theme";
    package = pkgs.kdePackages.sddm;
    extraPackages = with pkgs; [
      # kdePackages.qt6-declarative
      kdePackages.qtsvg
      kdePackages.qtsvg
      kdePackages.qtmultimedia
      kdePackages.qtvirtualkeyboard
    ];
    settings = {
      # Autologin = {
      #   Session = "hyprland";
      #   User = "${username}";
      # };
      General.GreeterEnvironment = lib.concatStringsSep "," [
        "XCURSOR_THEME=${cursorTheme}"
        "XCURSOR_SIZE=${toString cursorSize}"
        # Nix-patched libXcursor does not search /run/current-system/sw/share/icons
        # (there is no /usr/share/icons on NixOS), so point it there explicitly,
        # otherwise the greeter's compositor can't find the theme and shows no cursor.
        "XCURSOR_PATH=/run/current-system/sw/share/icons"
      ];
      Theme = {
        CursorTheme = cursorTheme;
        CursorSize = cursorSize;
      };
    };
  };

  environment.systemPackages = [
    (if stylixEnabled then
      let
        colors = config.lib.stylix.colors.withHashtag;
      in
      pkgs.sddm-astronaut.override {
        themeConfig = {
          Background = "${config.stylix.image}";
          CursorColor = colors.base05;
          FullBlur = "true";
          PartialBlur = "true";
          HeaderTextColor = colors.base05;
          HaveFormBackground = "false";
          FormPosition = "left";
        };
      }
    else
      pkgs.sddm-astronaut)
    # Install the fallback cursor theme system-wide so the greeter can use it
    # (this also covers the stylix-enabled case; stylix may switch themes via its own cursor package)
  ] ++ lib.optionals (!stylixEnabled) [ pkgs.capitaine-cursors ];

  security.pam.services.sddm.enableGnomeKeyring = true;
  security.pam.services.hyprlock.enableGnomeKeyring = true;
}
