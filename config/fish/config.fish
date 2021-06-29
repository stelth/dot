set -gx EDITOR nvim

set -Ux fish_user_paths

# Path
fish_add_path ~/.local/bin
fish_add_path ~/.cargo/bin
fish_add_path ~/.node/node_modules/.bin

if test -d /home/linuxbrew
    fish_add_path /home/linuxbrew/.linuxbrew/bin
    eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
end

fish_vi_key_bindings

# Fish
set -U fish_emoji_width 2

# Exports
set -Ux EDITOR nvim
set -Ux VISUAL nvim
set -Ux LESS -rF
set -Ux BAT_THEME Nord
set -Ux MANPAGER "nvim +Man!"
set -Ux MANROFFOPT -c

# Tmux
abbr t tmux
abbr tc 'tmux attach'
abbr ta 'tmux attach -t'
abbr tad 'tmux attach -d -t'
abbr ts 'tmux new -s'
abbr tl 'tmux ls'
abbr tk 'tmux kill-session -t'
abbr mux tmuxinator

abbr mv 'mv -iv'
abbr cp 'cp -riv'
abbr mkdir 'mkdir -vp'
alias -s ls 'exa --color=always --icons --group-directories-first'
alias -s la 'exa --color=always --icons --group-directories-first --all'
alias -s ll 'exa --color=always --icons --group-directories-first --all --long'
abbr l ll
abbr ncdu 'ncdu --color dark'

# Editor
abbr vim nvim
abbr vi nvim
abbr v nvim

# Dev
abbr git hub
abbr g hub
abbr lg lazygit
abbr gl 'hub l --color | devmoji --log --color | less -rXF'
abbr st 'hub st'
abbr push 'hub push'
abbr pull 'hub pull'

# Other
abbr su 'su -'
abbr df 'grc /bin/df -h'
abbr rga 'rg -uu'
abbr grep rg
abbr show-cursor 'tput cnorm'
abbr hide-cursor 'tput civis'
