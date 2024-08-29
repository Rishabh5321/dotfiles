{
  pkgs,
  inputs,
  config,
  spicetify-nix,
  ...
}: {
  imports = [inputs.spicetify-nix.homeManagerModules.default];
  programs.spicetify = let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
    palette = config.stylix.base16Scheme;
  in {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      adblock
      hidePodcasts
      shuffle # shuffle+ (special characters are sanitized out of extension names)
    ];
    theme = spicePkgs.themes.ziro;
    colorScheme = "custom";
    customColorScheme = {
      text = "${palette.base0B}";
      subtext = "${palette.base0B}";
      main = "${palette.base00}";
      main-elevated = "${palette.base00}";
      main-transition = "${palette.base00}";
      highlight = "${palette.base01}";
      highlight-elevated = "${palette.base00}";
      sidebar = "${palette.base00}";
      player = "${palette.base00}";
      card = "${palette.base05}";
      shadow = "${palette.base00}";
      selected-row = "${palette.base0B}";
      button = "${palette.base04}";
      button-active = "${palette.base07}";
      button-disabled = "${palette.base03}";
      tab-active = "${palette.base07}";
      notification = "${palette.base0B}";
      notification-error = "${palette.base06}";
      misc = "${palette.base02}";
      progress-fg = "${palette.base07}";
      progress-bg = "${palette.base00}";
      heart = "${palette.base07}";
      pagelink-active = "${palette.base04}";
      radio-btn-active = "${palette.base04}";
    };
  };
}
