{
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.nur.hmModules.nur
  ];

  programs.firefox = {
    enable = true;

    profiles."stelth" = {
      extensions = with config.nur.repos.rycee.firefox-addons; [
        behind-the-overlay-revival
        # bypass-paywalls-clean
        clearurls
        darkreader
        decentraleyes
        facebook-container
        localcdn
        onepassword-password-manager
        tridactyl
        ublock-origin
      ];

      settings = {
        "gfx.webrender.all" = true;
        "media.ffmpeg.vaapi.enabled" = true;
        "widget.dmabuf.force-enabled" = true;

        "app.shield.optoutstudies.enables" = false;
        "app.update.auto" = false;
        "browser.bookmarks.restore_default_bookmarks" = false;
        "browser.contentblocking.category" = "strict";
        "browser.ctrlTab.recentlyUsedOrder" = false;
        "browser.discovery.enabled" = false;
        "browser.laterrun.enabled" = false;
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
        "browser.newtabpage.activity-stream.feeds.snippets" = false;
        "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.havePinned" = "";
        "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.searchEngines" = "";
        "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.pinned" = false;
        "browser.protections_panel.infoMessage.seen" = true;
        "browser.quitShortcut.disabled" = true;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.ssb.enabled" = true;
        "browser.toolbars.bookmarks.visibility" = "never";
        "browser.urlbar.suggest.openpage" = false;
        "datareporting.policy.dataSubmissionEnable" = false;
        "datareporting.policy.dataSubmissionPolicyAcceptedVersion" = 2;
        "dom.security.https_only_mode" = true;
        "dom.security.https_only_mode_ever_enabled" = true;
        "extensions.getAddons.showPane" = false;
        "extensions.htmlaboutaddons.recommendations.enabled" = false;
        "extensions.pocket.enabled" = false;
        "identity.fxaccounts.enabled" = false;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
      };
    };
  };

  home = {
    sessionVariables.BROWSER = "firefox";

    persistence = {
      "/persist/home/stelth".directories = [
        ".mozilla"
      ];
    };
  };

  xdg.mimeApps.defaultApplications = {
    "text/html" = ["firefox.desktop"];
    "text/xml" = ["firefox.desktop"];
    "x-scheme-handler/http" = ["firefox.desktop"];
    "x-scheme-handler/https" = ["firefox.desktop"];
  };
}
