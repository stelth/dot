{pkgs, ...}: ''
  window {
      font-family: monospace;
      font-size: 12pt;
      color: #cdd6f4; /* text */
      background-color: rgba(30, 30, 46, 0.5);
  }

  button {
      background-repeat: no-repeat;
      background-position: center;
      background-size: 25%;
      border: none;
      background-color: rgba(30, 30, 46, 0);
      margin: 5px;
      transition: box-shadow 0.2s ease-in-out, background-color 0.2s ease-in-out;
  }

  button:hover {
      background-color: rgba(49, 50, 68, 0.1);
  }

  button:focus {
      background-color: #cba6f7;
      color: #1e1e2e;
  }

  #lock {
    background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/lock.png"), url("${pkgs.wlogout}/local/share/wlogout/icons/lock.png"));
  }

  #logout {
    background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/logout.png"), url("${pkgs.wlogout}/local/share/wlogout/icons/logout.png"));
  }

  #suspend {
    background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/suspend.png"), url("${pkgs.wlogout}/local/share/wlogout/icons/suspend.png"));
  }

  #hibernate {
    background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/hibernate.png"), url("${pkgs.wlogout}/local/share/wlogout/icons/hibernate.png"));
  }

  #shutdown {
    background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/shutdown.png"), url("${pkgs.wlogout}/local/share/wlogout/icons/shutdown.png"));
  }

  #reboot {
    background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/reboot.png"), url("${pkgs.wlogout}/local/share/wlogout/icons/reboot.png"));
  }

''
