{pkgs, ...}: {
  home.packages = [
    (pkgs.writeShellScriptBin "mangohud-opengl" ''
      ${pkgs.mangohud}/bin/mangohud --dlsym $@
    '')
    pkgs.mangohud
  ];

  xdg.configFile."MangoHud/MangoHud.conf".text = ''
    output_folder=/home/nix/mango-stats
    permit_upload=1
    cpu_temp
    gpu_temp
    cpu_mhz
  '';
}
