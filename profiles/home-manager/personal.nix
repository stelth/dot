{ config, lib, pkgs, ... }:
{
  programs.git = {
    userEmail = "steel300@gmail.com";
    userName = "Jason Cox";
    signing = {
      key = "steel300@gmail.com";
      signByDefault = false;
    };
  };
}
