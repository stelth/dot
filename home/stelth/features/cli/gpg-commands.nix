{pkgs, ...}: let
  ssh = "${pkgs.openssh}/bin/ssh";
  gpg-connect-agent = "${pkgs.gnupg}/bin/gpg-connect-agent";
in {
  isUnlocked = "${pkgs.procps}/bin/pgrep 'gpg-agent' &> /dev/null && ${gpg-connect-agent} --hex 'learn' 'scd apdu 00 f1 00 00' /bye | ${pkgs.gnugrep}/bin/grep OK -q";
  unlock = "${ssh} -T localhost -o StrictHostKeyChecking=no exit";
}
