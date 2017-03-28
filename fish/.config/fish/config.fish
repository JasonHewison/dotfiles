set EDITOR nvim
set VISUAL nvim
set fish_greeting ""

set PATH node_modules/.bin $PATH

# Local config.
if [ -f ~/.local.fish ]
  . ~/.local.fish
end

alias vim "nvim"
alias dockerup="bash --login '/Applications/Docker/Docker Quickstart Terminal.app/Contents/Resources/Scripts/start.sh'"
