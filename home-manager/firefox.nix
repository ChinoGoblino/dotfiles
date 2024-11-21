{ pkgs, config, inputs, ... }:

{
	programs.firefox = {	
		enable = true;

    profiles.me = {
      name = "me";
      id = 0; #default

      search = {
        force = true;
        default = "Brave";
        order = [ "Brave" ];
        engines = {
          "Brave" = {
            urls = [{ template = "https://search.brave.com/search?q={searchTerms}"; }];
            definedAliases = [ "@b" ];
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
            iconUpdateURL = "https://wiki.nixos.org/favicon.png";
            updateInterval = 24 * 60 * 60 * 1000; # every day
            definedAliases = [ "@nw" ];
          };

          "Bing".metaData.hidden = true;
        };
      };

      extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
        bitwarden
        ublock-origin
        vimium
      ];

      # TODO: Make more elegant
   #   extensions = with pkgs.firefox-addons; [
   #     bitwarden
   #     ublock-origin
   #     vimium
   #   ];
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
      FirefoxSuggest = {
        WebSuggestions = false;
        SponsoredSuggestions = false;
        ImproveSuggest = false;
      };
      DNSOverHTTPS = {
        Enabled = true;
      };
      SearchSuggestEnabled = false;

      # Check about:config for options
      Preferences = {
          "browser.startup.page" = 3;   # Save tabs on startup
      };
    };
  };
}
