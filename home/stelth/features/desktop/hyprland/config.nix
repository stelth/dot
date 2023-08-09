{home, ...}: let
  inherit (home.sessionVariables) TERMINAL BROWSER EDITOR;
in ''
  source=~/.config/hypr/rose-pine.conf

  general {
    gaps_in=2
    gaps_out=5
    border_size=2.7
    cursor_inactive_timeout=4
    col.active_border = $iris
    col.inactive_border = $muted
  }

  decoration {
    active_opacity=0.94
    inactive_opacity=0.84
    fullscreen_opacity=1.0
    rounding=5
    drop_shadow=true
    shadow_range=12
    shadow_offset=3 3
    col.shadow=rgba(1a1a1aee)
  }

  animations {
    enabled=true

    bezier=easein,0.11, 0, 0.5, 0
    bezier=easeout,0.5, 1, 0.89, 1
    bezier=easeinout,0.45, 0, 0.55, 1

    animation=windowsIn,1,3,easeout,slide
    animation=windowsOut,1,3,easein,slide
    animation=windowsMove,1,3,easeout

    animation=fadeIn,1,3,easeout
    animation=fadeOut,1,3,easein
    animation=fadeSwitch,1,3,easeout
    animation=fadeShadow,1,3,easeout
    animation=fadeDim,1,3,easeout
    animation=border,1,3,easeout

    animation=workspaces,1,2,easeout,slide
  }

  dwindle {
    split_width_multiplier=1.35
  }

  misc {
    vfr=on
  }

  input {
    kb_layout=us
    touchpad {
      disable_while_typing=false
    }
  }

  # Window Rules
  windowrule=workspace special,1Password

  # Startup
  exec = hyprpaper
  exec-once=waybar
  exec-once=mako
  exec-once=swayidle -w
  exec-once=1password

  # Mouse binding
  bindm=SUPER,mouse:272,movewindow
  bindm=SUPER,mouse:273,resizewindow

  # Program bindings
  bind=SUPER,Return,exec,${TERMINAL}
  bind=SUPER,w,exec,makoctl,dismiss
  bind=SUPER,v,exec,${TERMINAL} $SHELL -ic ${EDITOR}
  bind=SUPER,b,exec,${BROWSER}

  bind=SUPER,x,exec,rofi -show drun
  bind=SUPER,d,exec,rofi -show run

  # Lock screen
  bind=SUPER,backspace,exec,swaylock -S

  # Screenshots
  bind=,Print,exec,grimblast --notify copy output
  bind=SHIFT,Print,exec,grimblast --notify copy active
  bind=CONTROL,Print,exec,grimblast --notify copy screen
  bind=SUPER,Print,exec,grimblast --notify copy window
  bind=ALT,Print,exec,grimblast --notify copy area

  # Keyboard controls
  bind=,XF86AudioNext,exec,playerctl next
  bind=,XF86AudioPrev,exec,playerctl previous
  bind=,XF86AudioPlay,exec,playerctl play-pause
  bind=,XF86AudioStop,exec,playerctl stop
  bind=ALT,XF86AudioNext,exec,playerctld shift
  bind=ALT,XF86AudioPrev,exec,playerctld unshift
  bind=ALT,XF86AudioPlay,exec,systemctl --user restart playerctld

  bind=,XF86AudioRaiseVolume,exec,pactl set-sink-volume @DEFAULT_SINK@ +5%
  bind=,XF86AudioLowerVolume,exec,pactl set-sink-volume @DEFAULT_SINK@ -5%
  bind=,XF86AudioMute,exec,pactl set-sink-mute @DEFAULT_SINK@ toggle

  bind=SHIFT,XF86AudioMute,exec,pactl set-source-mute @DEFAULT_SOURCE@ toggle
  bind=,XF86AudioMicMute,exec,pactl set-source-mute @DEFAULT_SOURCE@ toggle

  # Window manager controls
  bind=SUPER,q,killactive
  bind=SUPER,e,exec,wlogout

  bind=SUPER,s,togglesplit
  bind=SUPER,f,fullscreen,1
  bind=SUPERSHIFT,f,fullscreen,0
  bind=SUPERSHIFT,space,togglefloating

  bind=SUPER,minus,splitratio,-0.25
  bind=SUPERSHIFT,minus,splitratio,-0.3333333

  bind=SUPER,equal,splitratio,0.25
  bind=SUPERSHIFT,equal,splitratio,0.3333333

  bind=SUPER,g,togglegroup
  bind=SUPER,apostrophe,changegroupactive,f
  bind=SUPERSHIFT,apostrophe,changegroupactive,b

  bind=SUPER,left,movefocus,l
  bind=SUPER,right,movefocus,r
  bind=SUPER,up,movefocus,u
  bind=SUPER,down,movefocus,d
  bind=SUPER,h,movefocus,l
  bind=SUPER,l,movefocus,r
  bind=SUPER,k,movefocus,u
  bind=SUPER,j,movefocus,d

  bind=SUPERSHIFT,left,swapwindow,l
  bind=SUPERSHIFT,right,swapwindow,r
  bind=SUPERSHIFT,up,swapwindow,u
  bind=SUPERSHIFT,down,swapwindow,d
  bind=SUPERSHIFT,h,swapwindow,l
  bind=SUPERSHIFT,l,swapwindow,r
  bind=SUPERSHIFT,k,swapwindow,u
  bind=SUPERSHIFT,j,swapwindow,d

  bind=SUPERCONTROL,left,focusmonitor,l
  bind=SUPERCONTROL,right,focusmonitor,r
  bind=SUPERCONTROL,up,focusmonitor,u
  bind=SUPERCONTROL,down,focusmonitor,d
  bind=SUPERCONTROL,h,focusmonitor,l
  bind=SUPERCONTROL,l,focusmonitor,r
  bind=SUPERCONTROL,k,focusmonitor,u
  bind=SUPERCONTROL,j,focusmonitor,d

  bind=SUPERCONTROL,1,focusmonitor,DP-1
  bind=SUPERCONTROL,2,focusmonitor,DP-2

  bind=SUPERCONTROLSHIFT,left,movewindow,mon:l
  bind=SUPERCONTROLSHIFT,right,movewindow,mon:r
  bind=SUPERCONTROLSHIFT,up,movewindow,mon:u
  bind=SUPERCONTROLSHIFT,down,movewindow,mon:d
  bind=SUPERCONTROLSHIFT,h,movewindow,mon:l
  bind=SUPERCONTROLSHIFT,l,movewindow,mon:r
  bind=SUPERCONTROLSHIFT,k,movewindow,mon:u
  bind=SUPERCONTROLSHIFT,j,movewindow,mon:d

  bind=SUPERALT,left,movecurrentworkspacetomonitor,l
  bind=SUPERALT,right,movecurrentworkspacetomonitor,r
  bind=SUPERALT,up,movecurrentworkspacetomonitor,u
  bind=SUPERALT,down,movecurrentworkspacetomonitor,d
  bind=SUPERALT,h,movecurrentworkspacetomonitor,l
  bind=SUPERALT,l,movecurrentworkspacetomonitor,r
  bind=SUPERALT,k,movecurrentworkspacetomonitor,u
  bind=SUPERALT,j,movecurrentworkspacetomonitor,d

  bind=SUPER,u,togglespecialworkspace
  bind=SUPERSHIFT,u,movetoworkspace,special

  bind=SUPER,1,workspace,01
  bind=SUPER,2,workspace,02
  bind=SUPER,3,workspace,03
  bind=SUPER,4,workspace,04
  bind=SUPER,5,workspace,05
  bind=SUPER,6,workspace,06
  bind=SUPER,7,workspace,07
  bind=SUPER,8,workspace,08
  bind=SUPER,9,workspace,09
  bind=SUPER,0,workspace,10
  bind=SUPER,f1,workspace,11
  bind=SUPER,f2,workspace,12
  bind=SUPER,f3,workspace,13
  bind=SUPER,f4,workspace,14
  bind=SUPER,f5,workspace,15
  bind=SUPER,f6,workspace,16
  bind=SUPER,f7,workspace,17
  bind=SUPER,f8,workspace,18
  bind=SUPER,f9,workspace,19
  bind=SUPER,f10,workspace,20
  bind=SUPER,f11,workspace,21
  bind=SUPER,f12,workspace,22

  bind=SUPERSHIFT,1,movetoworkspacesilent,01
  bind=SUPERSHIFT,2,movetoworkspacesilent,02
  bind=SUPERSHIFT,3,movetoworkspacesilent,03
  bind=SUPERSHIFT,4,movetoworkspacesilent,04
  bind=SUPERSHIFT,5,movetoworkspacesilent,05
  bind=SUPERSHIFT,6,movetoworkspacesilent,06
  bind=SUPERSHIFT,7,movetoworkspacesilent,07
  bind=SUPERSHIFT,8,movetoworkspacesilent,08
  bind=SUPERSHIFT,9,movetoworkspacesilent,09
  bind=SUPERSHIFT,0,movetoworkspacesilent,10
  bind=SUPERSHIFT,f1,movetoworkspacesilent,11
  bind=SUPERSHIFT,f2,movetoworkspacesilent,12
  bind=SUPERSHIFT,f3,movetoworkspacesilent,13
  bind=SUPERSHIFT,f4,movetoworkspacesilent,14
  bind=SUPERSHIFT,f5,movetoworkspacesilent,15
  bind=SUPERSHIFT,f6,movetoworkspacesilent,16
  bind=SUPERSHIFT,f7,movetoworkspacesilent,17
  bind=SUPERSHIFT,f8,movetoworkspacesilent,18
  bind=SUPERSHIFT,f9,movetoworkspacesilent,19
  bind=SUPERSHIFT,f10,movetoworkspacesilent,20
  bind=SUPERSHIFT,f11,movetoworkspacesilent,21
  bind=SUPERSHIFT,f12,movetoworkspacesilent,22

  blurls=waybar
''
