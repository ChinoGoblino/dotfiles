{ pkgs, config, inputs, ... }:

{
	programs.firefox = {	
		enable = true;

    profiles.me = {
      name = "me";
      id = 0; #default

      search = {
        force = true;
        default = "Startpage";
        order = [ "Startpage" ];
        engines = {
          "Startpage" = {
            urls = [{ template = "https://www.startpage.com/sp/search?q={searchTerms}"; }];
            definedAliases = [ "@s" ];
          };  

          "Nix Packages" = {
            urls = [{
              template = "https://search.nixos.org/packages";
              params = [
                { name = "type"; value = "packages"; }
                { name = "query"; value = "{searchTerms}"; }
              ];
            }];

            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };

          "NixOS Wiki" = {
            urls = [{ template = "https://wiki.nixos.org/index.php?search={searchTerms}"; }];

            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@nw" ];
          };

          "Bing".metaData.hidden = true;
          "Google".metaData.alias = "@g";
        };
      };

      extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
        bitwarden
        ublock-origin
        vimium
        simplelogin
        leechblock-ng
        nighttab
      ];

      # TODO: Make more elegant
 #     extensions = with pkgs.inputs.firefox-addons; [
 #       bitwarden
 #       ublock-origin
 #       vimium
 #     ];
    };

    # Check about:policies for options
    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      DisablePocket = true;
      DisableFirefoxAccounts = true;
      DisableAccounts = true;
      DisableFirefoxScreenshots = true;
      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";
      DisplayBookmarksToolbar = "never";
      OfferToSaveLogins = false;
      HttpsOnlyMode = "enabled";
      AutofillAddressEnabled = false;
      AutofillCreditCardEnabled = false;
      SearchSuggestEnabled = false;
      FirefoxSuggest = {
        WebSuggestions = false;
        SponsoredSuggestions = false;
        ImproveSuggest = false;
      };
      DNSOverHTTPS = {
        Enabled = true;
      };
      FirefoxHome = {
        SponsoredTopSites = false;
        SponsoredPocked = false;
      };

      # Check about:config for options
      Preferences = {
          "browser.startup.page" = 3;   # Save tabs on startup
      };

      # https://discourse.nixos.org/t/declare-firefox-extensions-and-settings/36265
      ExtensionSettings = {
        "{15cb5e64-94bd-41aa-91cf-751bb1a84972}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/catppuccin-macchiato-lavender2/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };
  };
}
