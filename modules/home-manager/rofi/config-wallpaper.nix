_: {
  home.file.".config/rofi/config-wallpaper.rasi".text = ''
    /* ---- 💫 https://github.com/JaKooLit 💫 ---- */
    /* Main Config (wallpaper) */

    @import "~/.config/rofi/config.rasi"

    /* ---- Configuration ---- */
    configuration {
      modi: "drun";
    }

    window {
      width: 60%;
    }

    /* ---- Imagebox ---- */
    imagebox {
      orientation: vertical;
      children:
        [ "entry", "listbox"];
    }


    entry {
      expand: false;
      placeholder: "🎞️ Choose Wallpaper";
    }

    /* ---- Listview ---- */
    listview {
      columns: 4;
      lines: 3;
    }

    /* ---- Element ---- */
    element {
      orientation: vertical;
      padding: 0px;
      spacing: 0px;
      border-radius: 15px;
    }

    element-icon {
      size: 20%;
    }

    element-text {
      font: "Fira Code SemiBold 12";
      vertical-align: 0.5;
      horizontal-align: 0.5;
    }
  '';
}
