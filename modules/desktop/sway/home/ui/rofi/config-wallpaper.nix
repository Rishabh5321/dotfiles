_: {
  home.file.".config/rofi/config-wallpaper.rasi".text = ''
    configuration {
      show-icons: true;
      drun-display-format: "{icon}";
    }

    window {
        width: 80%;
        height: 80%;
        transparency: "real";
        background-color: rgba(0,0,0,0.8);
    }

    listview {
        spacing: 20px;
        columns: 5;
        lines: 3;
    }

    element {
        orientation: vertical;
        padding: 10px;
    }

    element-icon {
        size: 12em;
    }

    element-text {
        horizontal-align: 0.5;
    }
  '';
}
