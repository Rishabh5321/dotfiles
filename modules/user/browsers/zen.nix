{ inputs, ... }:
{
  # home.nix
  imports = [
    inputs.zen-browser.homeModules.beta
    # or inputs.zen-browser.homeModules.twilight
    # or inputs.zen-browser.homeModules.twilight-official
  ];

  # stylix.targets.zen-browser.profileNames = ["main"];

  programs.zen-browser = {
    enable = true;
    policies = {
      DisableAppUpdate = true;
      DisableTelemetry = true;
      suppressXdgMigrationWarning = true;
      # find more options here: https://mozilla.github.io/policy-templates/
    };
  };
}
