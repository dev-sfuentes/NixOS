{pkgs, ...}: {
  user-manage.home.packages = [pkgs.brave];

  user-manage.xdg.desktopEntries."brave" = {
    name = "Brave";
    exec = "brave %U";
    icon = "brave-browser";
    categories = ["X-Rofi"];
  };
}
