{ pkgs
, inputs
, ...
}: {
  environment.systemPackages =
    #let                                                                   # deadnix: skip
    #cursor = pkgs.callPackage ../../pkgs/cursor.nix { };               # deadnix: skip  
    #grayjay = pkgs.callPackage ../../pkgs/grayjay.nix { };             # deadnix: skip
    #miru = pkgs.callPackage ../../pkgs/miru.nix { };                   # deadnix: skip
    #houdoku = pkgs.callPackage ../../pkgs/houdoku.nix { };             # deadnix: skip
    #grayjay_bye = pkgs.callPackage ../../pkgs/grayjay_bye.nix { };     # deadnix: skip
    #akuse = pkgs.callPackage ../../pkgs/akuse.nix { };                 # deadnix: skip
    #in                                                                    # deadnix: skip
    with pkgs; [
      act
      alacritty
      android-tools
      atuin
      bat
      beeper
      brave
      btop
      #clinfo
      cliphist
      cloudflare-warp
      code-cursor
      discord
      distrobox
      docker
      docker-compose
      dracula-icon-theme
      eza
      fastfetch
      fast-cli
      ferdium
      file-roller
      filezilla
      firefox
      #flatpak-builder
      fzf
      gamescope
      gedit
      gh
      git
      github-desktop
      gnome-console
      gnome-disk-utility
      gnome-keyring
      gnome-system-monitor
      google-chrome
      grim
      heroic
      htop
      inputs.akuse-flake.packages.${system}.akuse
      #inputs.alejandra.defaultPackage.${system}
      inputs.grayjay.packages.${system}.grayjay
      inputs.thorium.packages."x86_64-linux".thorium-avx2
      inputs.zen-browser.packages."${system}".default
      jellyfin-media-player
      kdePackages.dolphin
      kdePackages.qtstyleplugin-kvantum
      libsForQt5.qtstyleplugin-kvantum
      libreoffice
      librewolf
      libsForQt5.qt5.qtbase
      libsForQt5.qt5.qtsvg
      lutris
      mangayomi
      mangohud
      mesa
      micro
      miru
      mission-center
      mpv-unwrapped
      nautilus
      networkmanagerapplet
      nix-serve
      nh
      nwg-look
      obsidian
      onlyoffice-bin_latest
      papirus-icon-theme
      plex-media-player
      #protonup-qt
      qbittorrent
      qogir-icon-theme
      ranger
      #resilio-sync
      #revanced-cli
      rquickshare
      samba
      slurp
      speedtest-cli
      #spotdl
      spotify
      steam
      stremio
      swappy
      swww
      tela-icon-theme
      telegram-desktop
      thunderbird-latest
      tldr
      #tmux
      tree
      typer
      unrar
      unzip
      varia
      vim
      virt-viewer
      #vivaldi
      #vivaldi-ffmpeg-codecs
      vlc
      vscode
      wgcf
      wget
      winetricks
      wl-clipboard
      xdg-desktop-portal
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
      youtube-music
      zed-editor
      zsh
      inputs.better-control.packages.${pkgs.system}.better-control
      #age
      #akuse
      #amdvlk
      #appimage-run
      #authenticator
      #bitwarden-desktop
      #bottles
      #brightnessctl
      #cava
      #cmatrix
      #cowsay
      #cursor
      #distrobox
      #duf
      #ffmpeg
      #figlet
      #file-roller
      #floorp
      #gamescope
      #glxinfo
      #grayjay
      #grayjay_bye
      #houdoku
      #hyprlock
      #hyprpicker
      #hyprshot
      #imv
      #inputs.wfetch.packages.${pkgs.system}.default
      #intel-gpu-tools
      #inxi
      #jellyfin-media-player
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
      #miru
      #mpv
      #ncdu
      #neovide
      #ninja
      #nixfmt-rfc-style
      #nixos-generators
      #nvtopPackages.full
      #oh-my-posh
      #pavucontrol
      #pciutils
      #peaclock
      #pfetch-rs
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
      #tela-icon-theme
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
      #zed-editor
      #zinit
      #zoxide
      #zsh-powerlevel10k
    ];

  #services.plex.enable = true;
  #services.hypridle.enable = true;

  fonts = {
    packages = with pkgs; [
      #maple-mono
      noto-fonts
      noto-fonts-emoji
      noto-fonts-cjk-sans
      font-awesome
      symbola
      powerline
      fira-code
      fira-code-symbols
      material-icons
      nerd-fonts.ubuntu-sans
      nerd-fonts.ubuntu-mono
      nerd-fonts.ubuntu
      nerd-fonts.roboto-mono
      nerd-fonts.profont
      nerd-fonts.noto
      nerd-fonts.monaspace
      nerd-fonts.meslo-lg
      nerd-fonts.jetbrains-mono
    ];
  };
}
