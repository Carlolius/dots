# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Zsh Options
setopt auto_cd 			# If the command is not found, and it is a directory, cd into it.
setopt auto_list  		# automatically list choices on ambiguous completion
setopt auto_menu     		# automatically use menu completion
setopt auto_pushd 		# Push the current directory visited on the stack.
setopt cdable_vars 		# Change directory to a path stored in a variable.
setopt completealiases 		# complete aliases
setopt complete_in_word     	# Complete from both ends of a word.
setopt correct 			# Spell correction
setopt extended_glob        	# Use extended globbing syntax.
setopt menu_complete 		# Use menu completion.
setopt nomatch 			# print error if generation pattern has no match
setopt notify        		# status of the jobs inmediately
setopt pushd_ignore_dups    	# Do not store duplicates in the stack.
setopt pushd_silent         	# Do not print the directory stack after pushd or popd.

# History options
HISTFILE=$HOME/histfile
HISTSIZE=10000
SAVEHIST=10000
setopt append_history           # Intead rewrite the hole history, add the commands to the end.
setopt extended_history         # Write the history file in the ':start:elapsed;command' format.
setopt hist_expire_dups_first   # Expire a duplicate event first when trimming history.
setopt hist_ignore_dups         # Do not record an event that was just recorded again.
setopt hist_ignore_space        # Do not record an event starting with a space.
setopt hist_save_no_dups        # Do not write a duplicate event to the history file.
setopt hist_verify              # Do not execute immediately upon history expansion.
setopt share_history            # Share history between all sessions.

# Sources
[ -r  $HOME/.config/envrc ] && . $HOME/.config/envrc
source $HOME/.config/aliases
source $HOME/.config/functions
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Vim like
# Vi mode, change to insert mode with jk or kj
bindkey -v jk vi-cmd-mode
bindkey -v kj vi-cmd-mode
# Change cursor, change the beam to the block when in Vi normal mode
source "$HOME/.config/zsh/cursor_mode"
# Add Vi text-objects for brackets and quotes, and add a few more key bindings
autoload -Uz select-bracketed select-quoted
zle -N select-quoted
zle -N select-bracketed
for km in viopp visual; do
  bindkey -M $km -- '-' vi-up-line-or-history
  for c in {a,i}${(s..)^:-\'\"\`\|,./:;=+@}; do
    bindkey -M $km $c select-quoted
  done
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
    bindkey -M $km $c select-bracketed
  done
done

# Completion
source $HOME/.config/zsh/completion.zsh

# Autosuggestions
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
# History substring search
bindkey '^R' history-incremental-search-backward
# Next line binds the Ctrl + l to end of line in Vi normal mode
bindkey -v '^L' vi-end-of-line
bindkey -v '^J' vi-forward-word

# Prompt
autoload -Uz promptinit
promptinit

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
(( ! ${+functions[p10k]} )) || p10k finalize
