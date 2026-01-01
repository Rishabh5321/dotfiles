# Add your reusable home-manager modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
{ ... }:
{
  imports = [

    # APPS
    ./apps

    # Terminal Emulators
    ./terminal

    # Shells
    ./shells

    # System Monitoring
    ./monitor

    # File Management & Navigation
    ./files

    # Development Tools
    ./development

    # Entertainment & Media
    ./media

    # Gaming & Performance
    ./gaming

    # System & Utilities
    ./utilities

    # Theming & UI
    ./theme

    # Virtualization
    ./virtualization

    # Browsers
    ./browsers
  ];

  home.sessionVariables = {
    NH_OS_FLAKE = "$HOME/dotfiles";
  };

  manual = {
    json.enable = false;
    manpages.enable = false;
  };
}
