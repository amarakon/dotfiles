####################################
### Zsh History Substring Search ###
####################################
## Load the zsh-history-substring-search plugin.
. /usr/share/zsh/site-functions/zsh-history-substring-search.plugin.zsh > /dev/null 2>&1

## Search resulsts colors.
#HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND="fg=198,italic"
#HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND="fg=196,bold,"

## Ensure all resulsts are unique.
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1

############################
### Zsh Auto Suggestions ###
############################
## Load the zsh-autosuggestions plugin.
. usr/share/zsh/site-functions/zsh-autosuggestions.plugin.zsh > /dev/null 2>&1

## Set active suggestion groups.
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd history completion)

## Highlight suggestions as light grey.
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=242,italic"

################################
### Fast Syntax Highlighting ###
################################
## Load the fast-syntax-highlighting plugin.
. /usr/share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh > /dev/null 2>&1

## Set the fast-syntax-highlighting theme.
#fast-theme /usr/share/zsh/site-functions/themes/clean.ini > /dev/null 2>&1
#fast-theme I

#####################
### Zsh Autopairs ###
#####################
## Load the zsh-autopair plugin.
. /usr/share/zsh/site-functions/zsh-autopair.plugin.zsh

## Close autopairs if they are surrounded by whitespace.
AUTOPAIR_BETWEEN_WHITESPACE=1

###########################
### Zsh Many Dots Magic ###
###########################
## Load the zsh-many-dots-magic plugin.
. /usr/share/zsh/site-functions/manydots-magic > /dev/null 2>&1

