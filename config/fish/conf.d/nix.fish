set -l files ~/.nix-profile/etc/profile.d/nix.sh /etc/profiles/per-user/coxj/etc/profile.d/hm-session-vars.sh ~/.nix-profile/etc/profile.d/hm-session-vars.sh

set -e __HM_SESS_VARS_SOURCED
for f in $files
    test -f $f
    and replay source $f
end
