{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    kdePackages.sddm-kcm
    kdePackages.kdeconnect-kde
  ];
}
