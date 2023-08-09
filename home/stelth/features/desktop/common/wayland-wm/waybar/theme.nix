{...}: ''
  * {
    font-family: "Iosevka Nerd Font", "Iosevka Nerd Font Mono";
    font-size: 8pt;
    padding: 0 8px;
  }

  .modules-right {
    margin-right: -15px;
  }

  .modules-left {
    margin-left: -15px;
  }

  window#waybar.top {
    opacity: 0.95;
    padding: 0;
    background-color: #191724;
    border: 2px solid #9ccfd8;
    border-radius: 10px;
  }
  window#waybar.bottom {
    opacity: 0.90;
    background-color: #191724;
    border: 2px solid #9ccfd8;
    border-radius: 10px;
  }

  window#waybar {
    color: #e0def4;
  }

  #workspaces button {
    background-color: #1f1d2e;
    color: #e0def4;
    margin: 4px;
  }
  #workspaces button.hidden {
    background-color: #191724;
    color: #908caa;
  }
  #workspaces button.focused,
  #workspaces button.active {
    background-color: #ebbcba;
    color: #191724;
  }

  #clock {
    background-color: #9ccfd8;
    color: #191724;
    padding-left: 15px;
    padding-right: 15px;
    margin-top: 0;
    margin-bottom: 0;
    border-radius: 10px;
  }

  #custom-menu {
    background-color: #9ccfd8;
    color: #191724;
    padding-left: 15px;
    padding-right: 22px;
    margin-left: 0;
    margin-right: 10px;
    margin-top: 0;
    margin-bottom: 0;
    border-radius: 10px;
  }
  #custom-hostname {
    background-color: #9ccfd8;
    color: #191724;
    padding-left: 15px;
    padding-right: 18px;
    margin-right: 0;
    margin-top: 0;
    margin-bottom: 0;
    border-radius: 10px;
  }
  #tray {
    color: #e0def4;
  }
''
