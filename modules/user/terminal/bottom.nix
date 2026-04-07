{ ... }: {
  programs.bottom = {
    enable = true;
    settings = {
      enable_gpu = true;
      theme = "nord";
      flags.group_processes = true;
      row = [
        {
          ratio = 2;
          child = [
            { type = "cpu"; }
            { type = "temp"; }
          ];
        }
        {
          ratio = 2;
          child = [
            { type = "network"; }
          ];
        }
        {
          ratio = 3;
          child = [
            {
              type = "proc";
              ratio = 1;
              default = true;
            }
          ];
        }
      ];
    };
  };
}
