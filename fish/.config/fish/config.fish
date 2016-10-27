set EDITOR nvim
set VISUAL nvim
set fish_greeting ""

set PATH node_modules/.bin /Applications/MySQLWorkbench.app/Contents/MacOS $PATH

function fish_prompt
  ~/powerline-shell/powerline-shell.py $status --shell bare ^/dev/null
end

# Local config.
if [ -f ~/.local.fish ]
  . ~/.local.fish
end

alias vim "nvim"
