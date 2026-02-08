{
  inputs,
  pkgs,
  ...
}: {
  user-manage.home.packages = [inputs.tagstudio.packages.${pkgs.stdenv.hostPlatform.system}.tagstudio];

  user-manage.xdg.desktopEntries.tagstudio = {
    name = "TagStudio";
    exec = "tagstudio";
    icon = "tagstudio";
    categories = ["X-Rofi"];
  };

  user-manage.hyprland.windowrulev2 = map (title: "float, title:(" + title + ")") [
    "Add Tags — TagStudio"
    "Add Field — TagStudio"
    "Open/Create Library"
    "Library Tags — TagStudio"
    "Manage Tag Colors — TagStudio"
    "Fix Unlinked Entries — TagStudio"
    "Fix Ignored Entries — TagStudio"
    "Fix Duplicate Files — TagStudio"
    "Library Information — TagStudio"
  ];
}
