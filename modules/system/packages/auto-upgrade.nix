_: {
  system.autoUpgradeOnShutdown = {
    enable = true;
    flake = "github:rishabh5321/dotfiles";
    host = "dankmaterialbook";
    useNom = false;
    minimumBatteryToProceedWithoutAC = 80;
  };
}
