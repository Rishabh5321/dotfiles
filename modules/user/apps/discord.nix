{ inputs, username, ... }: {
  imports = [ inputs.nixcord.homeModules.nixcord ];

  programs.nixcord = {
    enable = true;
    user = "${username}";

    discord.vencord.enable = true;      # Standard Vencord
  };
}
