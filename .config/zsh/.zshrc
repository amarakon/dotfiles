source /etc/zsh/zprofile
source ~/.config/zsh/plugin.zsh

# ~/ Clean-up:
export HISTFILE=~/.cache/zsh/history

[ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ] && startx "$XDG_CONFIG_HOME/X11/xinitrc" &>/dev/null

. /usr/share/zsh/site-functions/_fzf
. /usr/share/fzf/key-bindings.zsh

# Keybindings
cl() { clear; zle reset-prompt }
za() { printf '\n' && a; zle reset-prompt }
zal() { printf '\n' && al; zle reset-prompt }
zat() { printf '\n' && at; zle reset-prompt }
cla() { clear && a; zle reset-prompt }
clal() { clear && al; zle reset-prompt }
clat() { clear && at; zle reset-prompt }
zdman() { printf '\n' ; apropos . | dmenu -l 10 | cut -d ' ' -f1 | xargs -I {} man "{}"; zle reset-prompt }
term() { setsid $TERMINAL --working-directory="$(pwd)" &> /dev/null; }
zbd() { bd && print && a ; zle reset-prompt; }

zle -N cl
zle -N za
zle -N zal
zle -N zat
zle -N cla
zle -N clal
zle -N clat
zle -N zdman
zle -N term
zle -N zbd

zmodload zsh/complist
bindkey -M menuselect '\t' accept-and-infer-next-history
bindkey '^Y' cl
bindkey '^K' zdman
bindkey '^A' term
bindkey '^N' za
bindkey '^E' zal
bindkey '^O' cla
bindkey '^B' zbd
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Confirmations

setopt rm_star_silent
setopt no_hist_verify

## Load the completion system.
autoload -Uz compinit

## Load the complist module.
zmodload zsh/complist

## Disable beeping on completions.
setopt NO_BEEP

## Automatically list ambiguous completions.
setopt AUTO_LIST

## Automatically use menu completion after the second request for completion.
setopt AUTO_MENU

## Always fully insert completions.
setopt MENU_COMPLETE

## Expand aliases to their corresponding command(s).
setopt COMPLETE_ALIASES

## Automatically remove trailing slashes from completions if nothing is added after them.
setopt AUTO_REMOVE_SLASH

## Automatically add a trailing slash to any parameter expression which points to a directory.
setopt AUTO_PARAM_SLASH

## Automatically put subscripts directly after parameter expressions.
setopt AUTO_PARAM_KEYS

## Allow completion within words (i.e. always complete at the cursor position).
setopt COMPLETE_IN_WORD

## Always move the cursor to the end of a completion after inserting it.
setopt ALWAYS_TO_END

## Automatically list compleptions when given an unambigous prefix.
setopt LIST_AMBIGUOUS

## Display markers to indicate what type of file a completion item is.
setopt LIST_TYPES

## List completion lists as compact as possible.
setopt LIST_PACKED

## Print an error when provided patterns that are badly formed.
setopt BAD_PATTERN

## Show hidden files and directories in the completion list.
_comp_options+=(globdots)

## When completing a string allow for a maximum of five errors before failing to find completion options.
#zstyle ':completion:*' max-errors 5

## When completion is first triggered provide a list of possible completion items.
## When completing a string attempt to expand the provided string. Otherwise, form completion
## options without account for spelling mistakes first, and then with spelling mistakes accounted for.
## If the completion did not succeed, then treat the string as a pattern.
zstyle ':completion:*' completer _expand _complete _approximate _match

## When expanding patterns generate matches based on the provided wildcard and support expanding
## shell expressions containing '$' and '`'. Finally, sort all expansions and insert all at once.
## Lastly, add a space after the inserted expansions.
zstyle ':completion::expand*' expand glob substitute sort all-expansions add-space

## Do not insert an '*' when attempting to match a pattern after completion fails.
zstyle ':completion::match:*' original only

## Assign group names for each completion item and group them together based on type.
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*' group-name ''

## Group all directories first in the completion list.
zstyle ':completion:*' list-dirs-first true

## Use $LS_COLORS for the completion list.
#zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} 'ma=48;2;76;86;106'

## Enable the completion selection menu only if there are at least four items.
#zstyle ':completion:*' menu select=4

## When attempting to match a string use case-insensitive matching.
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Change Selection Background Color
#zstyle ':completion:*' list-colors 'ma=48;2;76;86;106'

## Initialize the completion system.
compinit -i
