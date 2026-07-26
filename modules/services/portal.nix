{
  pkgs,
  user,
  ...
}: {
  environment.pathsToLink = ["/share/xdg-desktop-portal" "/share/applications"];

  user-manage = {
    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true; # Make xdg-open use the portal to open programs

      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
        kdePackages.xdg-desktop-portal-kde
        xdg-desktop-portal-gtk
      ];

      config.hyprland.default = [
        "hyprland"
        "kde"
        "gtk"
      ];
    };

    # Re-direct variable towards the correct path so the xdg-desktop-portal.service finds the DE-portals.conf
    home.sessionVariables.NIXOS_XDG_DESKTOP_PORTAL_CONFIG_DIR = "${user.config}/xdg-desktop-portal";

    # Makes sure to apply the window rules to the portal windows
    hyprland.windowrulev2 = let
      commonRules = [
        "float"
        "center 1"
        "size >80% >70%"
        "nomaxsize"
      ];
      # Apply common rules to all windows that match the following conditions
      applyRulesToConditions = conditions: builtins.concatLists (map (condition: map (rule: rule + ", " + condition) commonRules) conditions);
    in
      applyRulesToConditions [
        "title:(Save Video)"
        "title:(Save Image)"
        "class:(org.freedesktop.impl.portal.desktop.kde)"
        "class:(org.freedesktop.impl.portal.desktop.gtk)"
      ];
  };
}
