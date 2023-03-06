{...}: {
  system.defaults = {
    loginwindow = {
      GuestEnabled = false;
      SHOWFULLNAME = false;
    };

    finder = {
      AppleShowAllExtensions = true;
      FXEnableExtensionChangeWarning = false;
      _FXShowPosixPathInTitle = true;
    };

    trackpad = {
      ActuationStrength = 0;
      Clicking = true;
      Dragging = true;
      FirstClickThreshold = 1;
      SecondClickThreshold = 1;
      TrackpadRightClick = true;
    };

    dock = {
      autohide = true;
      autohide-delay = 0.0;
      autohide-time-modifier = 0.4;
      tilesize = 40;
      static-only = false;
      showhidden = false;
      show-recents = false;
      orientation = "left";
      mru-spaces = true;
      minimize-to-application = true;
    };

    NSGlobalDomain = {
      "com.apple.sound.beep.feedback" = 0;
      "com.apple.sound.beep.volume" = 0.0;
      ApplePressAndHoldEnabled = false;
      InitialKeyRepeat = 10;
      KeyRepeat = 2;
      AppleShowAllExtensions = true;
      AppleShowScrollBars = "Automatic";
    };
  };
}
