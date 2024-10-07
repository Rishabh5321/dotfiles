{pkgs,...}:
{
    environment.systemPackages = [
    (kodiPlugins.kodiWithPlugins (pkgs: with pkgs; [
        kodiPlugins.osmc-skin
                kodiPackages.inputstream-adaptive
        kodiPackages.youtube
        kodiPackages.pvr-iptvsimple
    ]))
    ];
}