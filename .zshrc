export EDITOR=vim

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:/home/bloadvenro/.gem/ruby/2.7.0/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/bloadvenro/.oh-my-zsh"


# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-nvm vi-mode docker docker-compose yarn)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias change_ttl="sudo bash -c 'echo 65 > /proc/sys/net/ipv4/ip_default_ttl'"

git_log_watch_graph() {
	watch -n 1 --color -- \
		git log \
			--graph \
			--all \
			--decorate \
			--pretty=format:'"%C(auto)%d %h %C(magenta)%s%n %C(black)🚹%an %ar "' \
			--color=always
}

git_status_watch() {
	watch -n -1 --color -- \
	 	git -c color.status=always status
}

alias gg="git log --graph --all --decorate --pretty=format:'%C(auto)%d %h %C(magenta)%s%n %C(normal)🚹%an %ar' --color=always"
alias ga="git add"
alias ggw="git_log_watch_graph"
alias gsw="git_status_watch"
alias gs="git status"
alias gd="git diff"
alias gdc="git diff --cached"
alias gb="git branch"
alias gbc="git checkout -b"
alias gc="git checkout"
alias cm="git commit"
alias gm="git merge"
alias gmf="git merge --no-ff"
alias grs="git reset HEAD -- "
alias gr="git rebase"
alias gri="git rebase -i"

alias pwd="pwd -P"

alias l="ls -F --color"
alias ls="ls -F --color"
alias l1="ls -F1 --color"
alias ll="ls -Flh --color"
alias la="ls -Flha --color"

alias rcp="rsync -avh --progress"

alias docker="sudo docker"

alias pacman.clean_cache="sudo paccache -r"

alias cls="clear"

# alias o="xdg-open"

o() {
	xdg-open $1 > /dev/null 2> /dev/null &
}

SSH_AGENT_SESSION=/home/$(whoami)/.ssh/agent-session

if ! [[ `pidof ssh-agent` ]]; then
	ssh-agent > $SSH_AGENT_SESSION
	chmod 600 $SSH_AGENT_SESSION
fi

eval $(cat $SSH_AGENT_SESSION)

tmux_create_sessions() {
	tmux new-session -s Default -d
	tmux new-session -s Gruzon -c ~/Projects/gruzon -d
	tmux new-session -s Verbs -c ~/Projects/verbs-api -d
	tmux new-session -s NestJSTaskManagement -c ~/Projects/nestjs-task-management -d
}

tmux_attach_default_session() {
	tmux attach-session -t Default
}

tmux_setup() {
	tmux_create_sessions
	tmux_attach_default_session
}

# Check if is not inside tmux environment
if ! [[ `echo $TMUX` ]]; then
	# Check if tmux is not running
	if ! [[ `pidof tmux` ]]; then
		tmux_setup
	else
		tmux_attach_default_session
	fi
fi

export WSL_WINDOWS_HOST=`cat /etc/resolv.conf | grep nameserver | cut -d ' ' -f 2`
