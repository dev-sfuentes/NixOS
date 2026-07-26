{user, ...}: {
  user-manage.programs.firefox.profiles.${user.name}.bookmarks = {
    force = true;

    settings = [
      # MARK: Favorites
      {
        name = "Favorites";
        bookmarks = [
          {
            url = "https://www.youtube.com";
            name = "Youtube";
          }
          {
            url = "https://www.reddit.com";
            name = "Reddit";
            keyword = "redd";
          }
          {
            url = "https://natomanga.com";
            name = "Natomanga";
            keyword = "manga";
          }
          {
            url = "https://mangadex.org";
            name = "MangaDex";
            keyword = "mdex";
          }
        ];
      }
      # MARK: Nix Sites
      {
        name = "Nix sites";
        bookmarks = [
          {
            url = "https://nixos.org";
            name = "Homepage";
            keyword = "nixorg";
          }
          {
            url = "https://wiki.nixos.org";
            name = "Wiki";
            keyword = "nwiki";
          }
          {
            url = "https://search.nixos.org/packages";
            name = "Nix packages";
            keyword = "np";
          }
          {
            url = "https://github.com/NixOS/nixpkgs";
            name = "Github Repository";
            keyword = "nrepo";
          }
          {
            url = "https://www.nixhub.io";
            name = "Nix hub";
            keyword = "nhub";
          }
          {
            url = "https://nur.nix-community.org";
            name = "NUR";
            keyword = "nur";
          }
          {
            url = "https://mynixos.com";
            name = "MyNixOS";
            keyword = "myn";
          }
          {
            url = "https://nlewo.github.io/nixos-manual-sphinx/index.html";
            name = "Nix documentation";
          }
        ];
      }
      # MARK: Entertainment
      {
        name = "Entertainment";
        bookmarks = [
          {
            url = "https://www.youtube.com";
            name = "Youtube";
            keyword = "yt";
          }
          {
            url = "https://www.twitch.tv";
            name = "Twitch";
            keyword = "twi";
          }
          {
            url = "https://www.netflix.com";
            name = "Netflix";
          }
          {
            url = "https://natomanga.com";
            name = "Natomanga";
            keyword = "manga";
          }
          {
            url = "https://zonatmo.com";
            name = "ZonaTMO";
            keyword = "tmo";
          }
          {
            url = "https://jkanime.net";
            name = "JKanime";
            keyword = "jka";
          }
          {
            url = "https://streamsports99.su";
            name = "StreamSports";
          }
          {
            url = "https://ntv.cx";
            name = "NTV";
          }
        ];
      }
      # MARK: Social Media
      {
        name = "Social Media";
        bookmarks = [
          {
            url = "https://web.whatsapp.com";
            name = "Whatsapp Web";
            keyword = "wsp";
          }
          {
            url = "https://www.instagram.com";
            name = "Instagram";
            keyword = "insta";
          }
          {
            url = "https://www.reddit.com";
            name = "Reddit";
            keyword = "redd";
          }
          {
            url = "https://www.facebook.com";
            name = "Facebook";
            keyword = "face";
          }
          {
            url = "https://www.linkedin.com";
            name = "LinkedIn";
          }
          {
            url = "https://www.tiktok.com/explore";
            name = "TikTok";
          }
          {
            url = "https://x.com";
            name = "X";
            keyword = "x";
          }
        ];
      }
      # MARK: Project Management
      {
        name = "Project Management";
        bookmarks = [
          {
            url = "https://www.atlassian.com";
            name = "Atlassian";
          }
          {
            url = "https://gitlab.com";
            name = "Gitlab";
            keyword = "glab";
          }
          {
            url = "https://github.com";
            name = "Github";
            keyword = "ghub";
          }
        ];
      }
      # MARK: Tools
      {
        name = "Tools";
        bookmarks = [
          {
            url = "https://languagetool.org";
            name = "LanguageTool";
            keyword = "lt";
          }
          {
            url = "https://chatgpt.com";
            name = "ChatGPT";
            keyword = "gpt";
          }
          {
            url = "https://mockapi.io";
            name = "MockAPI";
          }
          {
            url = "https://imageresizer.com";
            name = "Image Resizer";
          }
          {
            url = "https://www.remove.bg";
            name = "Background Remover";
          }
          {
            url = "https://www.watermarkremover.io";
            name = "Watermark Remover";
          }
          {
            url = "https://anyconv.com";
            name = "Files Converter";
          }
          {
            url = "https://app.diagrams.net";
            name = "Draw.io";
          }
          {
            url = "https://www.wappalyzer.com";
            name = "Wappalyzer";
          }
          {
            url = "https://devenv.sh";
            name = "DevEnv";
          }
          {
            url = "https://direnv.net";
            name = "DirEnv";
          }
          {
            url = "https://pcpartpicker.com";
            name = "PCPartPicker";
          }
          {
            url = "https://fmhy.net";
            name = "FMHY";
          }
        ];
      }
      # MARK: Utilities
      {
        name = "Utilities";
        bookmarks = [
          {
            # To compare times zones
            url = "https://www.worldtimebuddy.com";
            name = "World Time Buddy";
          }
          {
            # To check and possible find dev jobs
            url = "https://www.devjobsscanner.com";
            name = "Devjobs Scanner";
          }
          {
            # Compare electronics prices
            url = "https://www.solotodo.cl";
            name = "SoloTodo";
          }
          {
            # Cloud storage
            url = "https://drive.proton.me";
            name = "Proton Drive";
          }
        ];
      }
      # MARK: Informative
      {
        name = "Informative";
        bookmarks = [
          {
            # Submarine Cable map
            url = "https://www.submarinecablemap.com";
            name = "Submarine Cable Map";
          }
          {
            # To check if certain mail have been pwned
            url = "https://haveibeenpwned.com";
            name = "haveibeenpwned";
          }
          {
            # PlanetScale Blogs
            url = "https://planetscale.com/blog";
            name = "PlanetScale Blogs";
          }
        ];
      }
      # MARK: Apps
      {
        name = "Apps";
        bookmarks = [
          {
            url = "https://hyprland.org";
            name = "Hyprland";
          }
        ];
      }
      # MARK: Services
      {
        name = "Services";
        bookmarks = [
          {
            url = "http://localhost:8384";
            keyword = "sync";
            name = "Syncthing";
          }
          {
            url = "http://localhost:8096";
            keyword = "jelly";
            name = "Jellyfin";
          }
        ];
      }
      # MARK: E-Commerce
      {
        name = "E-Commerce";
        bookmarks = [
          {
            url = "https://aliexpress.com";
            name = "AliExpress";
          }
          {
            url = "https://www.temu.com";
            name = "Temu";
          }
          {
            url = "https://www.mercadolibre.cl";
            name = "MercadoLibre";
          }
        ];
      }
      # MARK: Wallpapers
      {
        name = "Wallpapers";
        bookmarks = [
          {
            url = "https://4kwallpapers.com";
            name = "4K Wallpapers";
          }
          {
            url = "https://www.artstation.com";
            name = "Artstation";
          }
          {
            url = "https://wallhaven.cc";
            name = "Wallhaven";
          }
        ];
      }
      # MARK: Icons
      {
        name = "Icons";
        bookmarks = [
          {
            url = "https://tabler.io/icons";
            name = "Tabler Icons";
          }
          {
            url = "https://www.flaticon.com";
            name = "Flaticon";
          }
          {
            url = "https://heroicons.com";
            name = "Heroicons";
          }
          {
            url = "https://icons8.com";
            name = "Icons8";
          }
          # Glyphs
          {
            url = "https://www.nerdfonts.com/cheat-sheet";
            name = "Nerd Fonts";
          }
          {
            url = "https://fontawesome.com";
            name = "FontAwesome";
          }
        ];
      }
      # MARK: Games Related
      {
        name = "Games Related";
        bookmarks = [
          {
            url = "https://store.steampowered.com";
            name = "Steam";
          }
        ];
      }
      # MARK: Country Wide
      {
        name = "Country Wide";
        bookmarks = [
          {
            url = "https://ayudamineduc.cl";
            name = "AyudaMineduc";
          }
          {
            url = "https://bancochile.cl";
            name = "Banco de Chile";
          }
          {
            url = "https://www.bancoestado.cl";
            name = "Banco Estado";
          }
        ];
      }
      # MARK: Linux Sites
      {
        name = "Linux sites";
        bookmarks = [
          {
            url = "https://www.kernel.org";
            keyword = "kernel";
            name = "kernel.org";
          }
        ];
      }
      # MARK: Firefox Sites
      {
        name = "Firefox sites";
        bookmarks = [
          {
            url = "about:config";
            keyword = "config";
            name = "Firefox Configuration";
          }
        ];
      }
      # MARK: Google Sites
      {
        name = "Google Sites";
        bookmarks = [
          {
            url = "https://translate.google.com";
            keyword = "trad";
            name = "Google Translate";
          }
          {
            url = "https://maps.google.com";
            keyword = "gmaps";
            name = "Google Maps";
          }
          {
            # Cloud storage
            url = "https://drive.google.com";
            name = "Google Drive";
          }
          {
            # Cloud Database
            url = "https://firebase.google.com";
            name = "Google Firebase";
          }
          {
            # Web Fonts
            url = "https://fonts.google.com";
            name = "Google Fonts";
          }
        ];
      }
      # Arr Suite
      {
        name = "Arr Suite";
        bookmarks = [
          {
            url = "http://localhost:9696";
            name = "Prowlarr";
          }
          {
            url = "http://localhost:7878";
            name = "Radarr";
          }
          {
            url = "http://localhost:8989";
            name = "Sonarr";
          }
          {
            url = "http://localhost:8686";
            name = "Lidarr";
          }
          {
            url = "http://localhost:6767";
            name = "Bazarr";
          }
        ];
      }
    ];
  };
}
