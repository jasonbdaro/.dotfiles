# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/jason/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="lambda-mod"
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
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
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    zsh-autosuggestions
		kube-ps1
)

source $ZSH/oh-my-zsh.sh

# User configuration
autoload -Uz compinit
compinit
# Completion for kitty
kitty + complete setup zsh | source /dev/stdin

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

source ~/.oh-my-zsh/plugins/kube-ps1/kube-ps1.plugin.zsh
PROMPT=$PROMPT'$(kube_ps1) '
# kube-ps1 configuration
KUBE_PS1_SYMBOL_DEFAULT=⎈
KUBE_PS1_SEPARATOR="~"

# Golang
#export PATH=$PATH:/usr/local/go/bin
#export GOPATH=$HOME/projects/golang
#export PATH=$PATH:/home/jason/projects/golang/bin/hello


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
alias vim="nvim"
alias vi="nvim"
alias app="tmuxp"
alias psclear="php artisan config:cache;php artisan view:clear;php artisan route:clear;composer dump-autoload -o;"
alias ps="cd ~/projects/prospark"
alias dl="cd ~/Downloads"
alias ssh@jta="ssh prospark@202.157.175.4"

# docker laradock
deti() {
    local project=$1
    docker exec --user=laradock -itw /var/www/prospark/$project laradock-workspace-1 zsh
}
deti8() {
    local project=$1
    docker exec --user=laradock -itw /var/www/prospark/$project laradock8-workspace-1 zsh
}

alias startapp="docker-compose up -d nginx adminer postgres mariadb redis"
alias stopapp="docker-compose stop"
alias restartapp="stopapp && startapp"

# git
alias cpick="git cherry-pick --no-commit"
alias commit="git commit -S -m"
alias gpod="git pull origin develop"
alias glog="git log --show-signature"
alias gpush="git push"
alias gpull="git pull"
alias co="git checkout "

#vim
clears() {
    rm -rf "/home/jason/.vim/sessions`pwd`"
}

#kubernetes
alias k="kubectl"
alias keti="kubectl exec -it"
alias kcuc="kubectx"
alias kgcc="kubectl config current-context"
alias kgcn="kubectl config view --minify | grep namespace"
alias kgp="kubectl get po"

kcn() {
  k config set-context --current --namespace=$1
}
kdump() {
    # comment below if you need only the dump
    docker exec -i laradock-mariadb-1 mariadb -uroot -proot -e "CREATE DATABASE IF NOT EXISTS "$1 && \
    echo "\nRestoring database "$1" ..." &&\
    docker exec -i laradock-mariadb-1 mariadb -uroot -proot $1 < ~/Downloads/$2 && \
    echo "Success!"
}
kdump8() {
    # comment below if you need only the dump
    docker exec -i laradock8-mariadb-1 mariadb -uroot -proot -e "CREATE DATABASE IF NOT EXISTS "$1 && \
    echo "\nRestoring database "$1" ..." &&\
    docker exec -i laradock8-mariadb-1 mariadb -uroot -proot $1 < ~/Downloads/$2 && \
    echo "Success!"
}
pdump() {
	docker exec -i laradock-postgres-1 psql -U default -c "CREATE DATABASE "$1 && \
		echo "\nRestoring database "$1" ..." && \
    docker exec -i laradock-postgres-1 psql -U default -d $1 < ~/Downloads/$2 && \
    echo "Success!"
}
pdump8() {
	docker exec -i laradock8-postgres-1 psql -U default -c "CREATE DATABASE "$1 && \
		echo "\nRestoring database "$1" ..." && \
    docker exec -i laradock8-postgres-1 psql -U default -d $1 < ~/Downloads/$2 && \
    echo "Success!"
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
