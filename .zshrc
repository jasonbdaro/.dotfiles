# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/jason/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="lambda-mod"

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
alias psclear="php artisan config:clear;php artisan config:cache;php artisan view:clear;php artisan route:clear;composer dump-autoload -o;"
alias blur="picom --experimental-backends --config ~/picom.conf -b;"
alias prospark="cd ~/projects/prospark"
alias personal="cd ~/projects/personal"

# docker laradock
deti() {
    local project=$1
    docker exec --user=laradock -itw /var/www/prospark/$project laradock-workspace-1 zsh
}

alias pfm="docker exec -it laradock-php-fpm_1"
alias ngx="docker exec -it laradock-nginx-1"
alias sln="docker exec -it laradock-selenium-1 bash"
alias ws="docker exec laradock-workspace-1"
#alias startapp="docker-compose up -d nginx mariadb adminer phpmyadmin workspace redis"
#alias startapp="docker-compose up -d nginx adminer postgres workspace"
alias startapp="docker-compose up -d nginx adminer postgres"
alias stopapp="docker-compose stop"
alias restartapp="stopapp && startapp"

# git
alias cpick="git cherry-pick --no-commit"
alias feature="git flow feature"
alias bugfix="git flow bugfix"
alias hotfix="git flow hotfix"
alias release="git flow release"
alias support="git flow support"
alias stash="git stash --include-untracked"
alias pop="git stash pop"
alias commit="git commit -S -m"
alias gpod="git pull origin develop"
alias glog="git log --show-signature"
alias gpush="git push"
alias gpull="git pull"

#kubernetes
alias k="kubectl"
alias keti="kubectl exec -it"
alias kcuc="kubectx"
alias kgcc="kubectl config current-context"
alias kgcn="kubectl config view --minify | grep namespace"
alias kgp="kubectl get po"

kcucl() {
    source ~/.oh-my-zsh/plugins/kube-ps1/kube-ps1.plugin.zsh
}
kcn() {
    k config set-context --current --namespace=$1
}
kimages() {
    kgp -o jsonpath="{.items[*].spec.containers[*].image}" | tr -s '[[:space:]]' '\n' | sort | uniq -c
}
kdb() {
    local pod="ms-db-mariadb-primary-0"
    local passwd=$(
        k get secret --namespace prospark $pod\
        -o jsonpath="{.data.mariadb-root-password}" | base64 --decode
    )

    keti $pod -- mysql -uroot -p$passwd
}
kdump() {
    local pod="ms-db-mariadb-primary-0"

    kubectx prospark-dev-eks && kcn prospark && \
    source ~/.oh-my-zsh/plugins/kube-ps1/kube-ps1.plugin.zsh

    #local passwd=$(
        #k get secret --namespace prospark $pod\
        #-o jsonpath="{.data.mariadb-root-password}" | base64 --decode
    #)
    #local uuser="sicepat_dev"
    #local passwd="QMNh4S4WmcDETmMZPBIqSsU7qR4yfPvZ"
    echo "\nEnter user:"
    read uuser
    echo "\nEnter password:"
    read passwd

    echo "\nGetting databases from pod "$pod":" && \
    keti $pod -- sh -c "exec mysql -u$uuser -p$passwd -e 'SHOW DATABASES;' | paste -s -d ' ' | sed 's/Database //'" &&\
    echo "\nSelect database(dump):"
    read db
    echo "\nEnter database(restore):"
    read db2

    local dump=$db"-"$(date +%Y%m%d%H%M)".sql"

    echo "\nGenerating database dump from "$db" ..." &&\
    keti $pod -- sh -c "exec mysqldump -u$uuser -p$passwd $db > /tmp/$dump" &&\
    k cp $pod:/tmp/$dump ~/Downloads/$dump &&\

    # comment below if you need only the dump
    docker exec -i laradock-mariadb-1 mysql -uroot -proot -e "CREATE DATABASE IF NOT EXISTS "$db2 && \
    echo "\nRestoring database "$db2" ..." &&\
    docker exec -i laradock-mariadb-1 mysql -uroot -proot $db2 < ~/Downloads/$dump && \
    echo "Cleaning up..."
    keti $pod -- sh -c "rm /tmp/$dump" &&\
    rm ~/Downloads/$dump &&\
    echo "Success!"
}
kdump2() {
    # comment below if you need only the dump
    docker exec -i laradock-mariadb-1 mysql -uroot -proot -e "CREATE DATABASE IF NOT EXISTS "$1 && \
    echo "\nRestoring database "$1" ..." &&\
    docker exec -i laradock-mariadb-1 mysql -uroot -proot $1 < ~/Downloads/$2 && \
    echo "Success!"
}
pdump() {
    docker exec -i laradock-postgres-1 psql -U default -d $1 < ~/Downloads/$2
}

envlms() {
    cp ~/projects/prospark/cpenv/env-lms . && mv env-lms .env &&\
    find .env -type f -exec sed -i "s/<customer>/$1/g" {} \;
}
envapi() {
        cp ~/projects/prospark/cpenv/env-api . && mv env-api .env &&\
        find .env -type f -exec sed -i "s/<customer>/$1/g" {} \;
}
envpwa() {
        cp ~/projects/prospark/cpenv/env-pwa . && mv env-pwa .env &&\
        find .env -type f -exec sed -i "s/<customer>/$1/g" {} \;
}

#gojek weekly report
source ~/projects/prospark/gj-weekly-report/generate.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
