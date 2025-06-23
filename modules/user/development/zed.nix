_:
{
  programs.zed-editor = {
    enable = true;

    extensions = [
      "nix"
    ];

    userSettings = {
      languages = {
        Nix = {
          language_servers = [
            "nil"
            "!nixd"
          ];
          formatter = {
            external = {
              command = "nixfmt";
            };
          };
        };
      };
    };
  };

  stylix.targets.zed.enable = false;
}
