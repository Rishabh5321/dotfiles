{ pkgs
, inputs
, ...
}: {
  environment.systemPackages =
    let
      cursor = pkgs.callPackage ../../pkgs/cursor.nix { };
    in
    with pkgs; [
      #age
      alacritty
      #amdvlk
      android-tools
      #appimage-run
      atuin
      #authenticator
      bat
      beeper
      #bitwarden-desktop
      #bottles
      brave
      #brightnessctl
      btop
      cava
      clinfo
      #cliphist
      #cmatrix
      #cowsay
      cursor
      dunst
      #dconf-editor
      discord
      distrobox
      docker
      docker-compose
      dracula-icon-theme
      #duf
      eza
      fast-cli
      fastfetch
      ffmpeg
      #figlet
      #file-roller
      filezilla
      firefox
      #floorp
      fzf
      gamescope
      gedit
      gh
      git
      github-desktop
      #glxinfo
      google-chrome
      grim
      heroic
      htop
      # hyprlock
      # hyprpicker
      # hyprshot
      # imv
      inputs.alejandra.defaultPackage.${system}
      #intel-gpu-tools # For Intel GPU tools
      # inxi
      inputs.zen-browser.packages."${system}".default
      jellyfin-media-player
      #kdePackages.kdeconnect-kde
      #kdePackages.sddm-kcm
      # killall
      #kodiPackages.inputstream-adaptive
      #kodi
      #lazycli
      lazydocker
      #lazygit
      #libnotify
      libreoffice
      #libsForQt5.krohnkite
      #libsForQt5.sddm-kcm
      libvirt
      #lm_sensors
      #lolcat
      #lshw
      #lsof
      #lutris
      #lxqt.lxqt-policykit
      #marwaita-icons
      mesa
      #meson
      micro
      #mpv
      #ncdu
      #neovide
      networkmanagerapplet
      nh
      nwg-look
      #ninja
      #nixfmt-rfc-style
      #nixos-generators
      nvtopPackages.full
      obsidian
      oh-my-posh
      onlyoffice-bin_latest
      #pavucontrol
      #pciutils # For lspci command
      peaclock
      pfetch-rs
      #pkg-config
      #playerctl
      #plex-media-player
      #polkit_gnome
      #protonup-qt
      qbittorrent
      #qemu
      quickemu
      #radeontop # For AMD GPU monitoring
      ranger
      #resilio-sync
      #ripgrep
      #rose-pine-icon-theme
      rquickshare
      #rtkit
      #sddm-astronaut
      #slurp
      #socat
      #sops
      speedtest-cli
      spicetify-cli
      spotify
      spotdl
      #steam
      stremio
      #swappy
      #swaynotificationcenter
      swww
      #swtpm
      telegram-desktop
      tldr
      tree
      #unetbootin
      unrar
      unzip
      #uwufetch
      #v4l-utils
      ventoy
      vim
      virt-viewer
      # vivaldi
      # vivaldi-ffmpeg-codecs
      vlc
      vscode
      #vulkan-tools # For vulkaninfo and other Vulkan tools
      #wayland-pipewire-idle-inhibit
      wget
      #wezterm
      wl-clipboard
      #wlroots
      #xfce.xfce4-pulseaudio-plugin
      # yad
      #ydotool
      #yubioath-flutter
      #zinit
      #zoxide
      zsh
      #zsh-powerlevel10k

      winetricks
      dconf-editor
      gnome-disk-utility
      gnome-system-monitor
      gnome-tweaks
      nautilus
      zed-editor
      inputs.wfetch.packages.${pkgs.system}.default

      libsForQt5.qt5.qtbase
      libsForQt5.qt5.qtsvg
    ];

  #services.plex.enable = true;
  #services.hypridle.enable = true;

  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-emoji
      noto-fonts-cjk
      font-awesome
      symbola
      powerline
      nerdfonts
      material-icons
      (nerdfonts.override { fonts = [ "Meslo" ]; })
    ];
  };
}
