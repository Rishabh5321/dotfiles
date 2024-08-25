{
  pkgs-unstable,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs-unstable; [
  ];
}
