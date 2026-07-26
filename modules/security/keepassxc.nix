{
  config,
  pkgs,
  user,
  ...
}: {
  user-manage = {
    home.packages = [pkgs.keepassxc];

    xdg.configFile."keepassxc/keepassxc.ini" = {
      force = false;

      text = ''
        [General]
        UseGroupIconOnEntryCreation=false
        FaviconDownloadTimeout=15
        NumberOfRememberedLastDatabases=1
        RememberLastKeyFiles=false
        UseAtomicSaves=false

        [Browser]
        CustomProxyLocation=
        Enabled=true

        [GUI]
        ApplicationTheme=dark
        ColorPasswords=true
        CompactMode=true
        HideMenubar=true
        HidePreviewPanel=true
        HideToolbar=false
        MinimizeOnClose=true
        MinimizeOnStartup=true
        MinimizeToTray=true
        HideUsernames=false
        ShowTrayIcon=true
        TrayIconAppearance=colorful

        [PasswordGenerator]
        AdditionalChars=
        ExcludedChars=
        Length=20

        [Security]
        ClearClipboardTimeout=60
        ClearSearch=true
        ClearSearchTimeout=2
        EnableCopyOnDoubleClick=true
        HidePasswordPreviewPanel=true
        HideTotpPreviewPanel=true
        IconDownloadFallback=true
        LockDatabaseIdle=false
        LockDatabaseIdleSeconds=600
        LockDatabaseMinimize=true
        NoConfirmMoveEntryToRecycleBin=false
        PasswordEmptyPlaceholder=true
        Security_HideNotes=true
      '';
    };

    xdg.desktopEntries."org.keepassxc.KeePassXC" = {
      name = "KeePassXC";
      exec = "keepassxc";
      mimeType = ["application/x-keepass2"];
      categories = ["X-Rofi"];
      icon = "keepassxc";
      startupNotify = true;
      settings = {
        SingleMainWindow = "true";
        X-GNOME-SingleWindow = "true";
      };
    };

    hyprland.exec-once = ["keepassxc"]; # It opens on startup, but in config it hides in tray.

    hyprland.windowrulev2 = [
      "pin, title:(Unlock Database - KeePassXC)"
      "focusonactivate, title:(Unlock Database - KeePassXC)"

      "pin, title:(KeePassXC - Browser Access Request)"
      "focusonactivate, title:(KeePassXC - Browser Access Request)"
    ];
  };

  # -- Sync folder with mobile device
  services.syncthing.settings.folders."Keepass" = {
    path = "${config.services.syncthing.dataDir}/Keepass";
    devices = ["mobile"];
  };
}
