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
      #amdvlk
      alacritty
      android-tools
      #appimage-run
      atuin
      #authenticator
      bat
      beeper
      bitwarden-desktop
      bottles
      #brave
      #brightnessctl
      btop
      brave
      inputs.alejandra.defaultPackage.${system}
      cava
      #cliphist
      #cmatrix
      #cowsay
      cursor
      discord
      distrobox
      docker
      docker-compose
      #duf
      eza
      fast-cli
      fastfetch
      ffmpeg
      #figlet
      #file-roller
      filezilla
      firefox
      floorp
      fzf
      gedit
      gh
      git
      github-desktop
      #glxinfo
      gnome-disk-utility
      gnome-system-monitor
      grim
      heroic
      htop
      # hyprlock
      # hyprpicker
      # hyprshot
      # imv
      #intel-gpu-tools # For Intel GPU tools
      # inputs.alejandra.defaultPackage.${system}
      # inxi
      jellyfin-media-player
      kdePackages.kdeconnect-kde
      # killall
      kodi-wayland
      #lazycli
      lazydocker
      #lazygit
      #libnotify
      libreoffice
      #libvirt
      #lm_sensors
      #lolcat
      #lshw
      lutris
      #lxqt.lxqt-policykit
      #mesa
      #meson
      micro
      #mpv
      nautilus
      #ncdu
      #neovide
      #networkmanagerapplet
      nh
      #ninja
      #nixfmt-rfc-style
      #nixos-generators
      nvtopPackages.full
      obsidian
      oh-my-posh
      onlyoffice-bin_latest
      #pavucontrol
      #pciutils
      #pciutils # For lspci command
      peaclock
      pfetch-rs
      #pkg-config
      #playerctl
      #plex-media-player
      #polkit_gnome
      protonup-qt
      qbittorrent
      #radeontop # For AMD GPU monitoring
      ranger
      #resilio-sync
      #ripgrep
      rquickshare
      #slurp
      #socat
      #sops
      speedtest-cli
      spicetify-cli
      spotify
      spotdl
      steam
      stremio
      #swappy
      #swaynotificationcenter
      #swww
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
      vlc
      vscode
      #vulkan-tools # For vulkaninfo and other Vulkan tools
      #wayland-pipewire-idle-inhibit
      wget
      #wezterm
      #wl-clipboard
      #wlroots
      #xfce.xfce4-pulseaudio-plugin
      # yad
      #ydotool
      #yubioath-flutter
      zed-editor
      #zinit
      #zoxide
      zsh
      #zsh-powerlevel10k

      #qemu
      #swtpm
      #rtkit
      #google-chrome
      # vivaldi
      # vivaldi-ffmpeg-codecs
      kdePackages.sddm-kcm
      # libsForQt5.krohnkite
      #libsForQt5.sddm-kcm
      #inputs.zen-browser.packages."${system}".generic
      marwaita-icons
      kodiPackages.inputstream-adaptive
      dracula-icon-theme
      libvirt
      quickemu
      sddm-astronaut
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
