{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    kdePackages.sddm-kcm
  ];
}
