{ pkgs
, inputs
, ...
}: {
  environment.systemPackages =
    let
      cursor = pkgs.callPackage ../../pkgs/cursor.nix { };
      grayjay = pkgs.callPackage ../../pkgs/grayjay.nix { };
      grayjay_bye = pkgs.callPackage ../../pkgs/grayjay_bye.nix { };
      miru = pkgs.callPackage ../../pkgs/miru.nix { };
      migu = pkgs.callPackage ../../pkgs/migu.nix { };
      unyo = pkgs.callPackage ../../pkgs/unyo.nix { };
    in
    with pkgs; [
      unyo
      migu
      miru
      ethtool
      grayjay
      grayjay_bye
      mission-center
      flatpak-builder
      alacritty
      android-tools
      atuin
      bat
      beeper
      brave
      btop
      clinfo
      cliphist
      #cloudflare-warp
      cursor
      discord
      distrobox
      docker
      docker-compose
      dracula-icon-theme
      eza
      fast-cli
      fastfetch
      filezilla
      firefox
      fzf
      #gamescope
      gedit
      gh
      git
      github-desktop
      gnome-console
      gnome-disk-utility
      gnome-system-monitor
      google-chrome
      grim
      htop
      #jellyfin-media-player
      libreoffice
      libsForQt5.qt5.qtbase
      libsForQt5.qt5.qtsvg
      mesa
      micro
      nautilus
      networkmanagerapplet
      nh
      nwg-look
      obsidian
      #oh-my-posh
      onlyoffice-bin_latest
      #pfetch-rs
      plex-media-player
      qbittorrent
      ranger
      rquickshare
      samba
      slurp
      speedtest-cli
      spotify
      spotdl
      swappy
      swww
      telegram-desktop
      tldr
      tmux
      tree
      unrar
      unzip
      vim
      virt-viewer
      vlc
      wgcf
      wget
      wl-clipboard
      zsh

      inputs.alejandra.defaultPackage.${system}
      inputs.zen-browser.packages."${system}".default

      #age
      #amdvlk
      #appimage-run
      #authenticator
      #bitwarden-desktop
      #bottles
      #brightnessctl
      #cava
      #cmatrix
      #cowsay
      #distrobox
      #duf
      #ffmpeg
      #figlet
      #file-roller
      #floorp
      #glxinfo
      #hyprlock
      #hyprpicker
      #hyprshot
      #imv
      #inputs.wfetch.packages.${pkgs.system}.default
      #intel-gpu-tools
      #inxi
      #kdePackages.kdeconnect-kde
      #kdePackages.sddm-kcm
      #killall
      #kodi
      #kodiPackages.inputstream-adaptive
      #lazycli
      #lazygit
      #libnotify
      #libsForQt5.krohnkite
      #libsForQt5.sddm-kcm
      #libvirt
      #lm_sensors
      #lolcat
      #lshw
      #lsof
      #lxqt.lxqt-policykit
      #marwaita-icons
      #meson
      #mpv
      #ncdu
      #neovide
      #ninja
      #nixfmt-rfc-style
      #nixos-generators
      #nvtopPackages.full
      #pavucontrol
      #pciutils
      #peaclock
      #pkg-config
      #playerctl
      #polkit_gnome
      #qemu
      #quickemu
      #radeontop
      #resilio-sync
      #ripgrep
      #rose-pine-icon-theme
      #rtkit
      #sddm-astronaut
      #socat
      #sops
      #spicetify-cli
      #steam
      #swaynotificationcenter
      #swtpm
      #unetbootin
      #uwufetch
      #v4l-utils
      #ventoy
      #vivaldi
      #vivaldi-ffmpeg-codecs
      #vulkan-tools
      #wayland-pipewire-idle-inhibit
      #wezterm
      #wlroots
      #xfce.xfce4-pulseaudio-plugin
      #yad
      #ydotool
      #yubioath-flutter
      #zinit
      #zoxide
      #zsh-powerlevel10k
    ];

  #services.plex.enable = true;
  #services.hypridle.enable = true;

  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-emoji
      noto-fonts-cjk-sans
      font-awesome
      symbola
      powerline
      material-icons
      nerdfonts # for 24.11

      #for unstable
      # nerd-fonts.ubuntu-sans
      # nerd-fonts.ubuntu-mono
      # nerd-fonts.ubuntu
      # nerd-fonts.roboto-mono
      # nerd-fonts.profont
      # nerd-fonts.noto
      # nerd-fonts.monaspace
      # nerd-fonts.meslo-lg
      # nerd-fonts.jetbrains-mono
    ];
  };
}
