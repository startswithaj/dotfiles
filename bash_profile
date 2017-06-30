# Commands I forget
# list functions declare -f

alias obp="code ~/.bash_profile"

for file in ~/.{bash_prompt,work}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# History

export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
shopt -s histappend                      # append to history, don't overwrite it
shopt -s cmdhist

# export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND" # Save and reload the history after each command finishes

shopt -s nocaseglob;                     # Case-insensitive globbing (used in pathname expansion)

shopt -s histappend;                     # Append to the Bash history file, rather than overwriting it

shopt -s cdspell;                       # Autocorrect typos in path names when using `cd`


if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

alias   del="rmtrash"
alias rm="echo Use 'del', or the full path i.e. '/bin/rm'"

# git
alias gs="git status -s"
alias pretty="--graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
alias glme="git log --author=Jake "

alias cleantracking='git remote prune origin'
alias tracking='git for-each-ref --format="%(refname:short)" | while read b; do if r=$(git config --get branch.$b.remote); then m=$(git config --get branch.$b.merge); echo "$b -> $r/${m##*/}"; fi; done'
alias authors='git shortlog -s -n --all' #an use -e as well for ungrouped

alias lgm='git log -1 --pretty | pbcopy'
alias lgc='git log --pretty=format:%h -n 1 | pbcopy'        # last git commit hash

alias yds='yarn dev-server-hot'
alias yb='yarn bootstrap'
gc() { git branch | grep $@ | sed -n 1p | xargs git checkout; }

# Using tig now
# fgd() { find . -iname $@ | xargs git diff; }
# fgc() { find . -iname $@ | xargs git checkout; }
# fga() { find . -iname $@ | xargs git add; }

# JS $tuff
alias js2cf='pbpaste | js2coffee | pbcopy'

# convertsall javascript files to respective .coffee
# alias alljs2cf='find . -type f -name "*.js" | while read f; do echo "grinding $f to ${f/.js/.coffee} "; js2coffee "$f" > "${f/.js/.coffee}"; done'
# alias rmalljs='find . -type f -name "*.js" | while read f; do echo "deleting $f "; rm $f; done'

# alias node-debug-grunt="node-debug $(which grunt)"
# alias node-debug-coffee="node-debug $(which coffee)"

# Misc

md () { mkdir -p "$@" && cd "$@"; }
v () { more node_modules/"$@"/package.json | jq .version; }
f () { find . -name $@; }
fd() { find . -type d -name $@; }

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~" # `cd` is probably faster to type though
alias -- -="cd -"

alias dev='cd ~/dev'

alias ll='ls -lah'
# alias for groc'ing any coffee files in a folder recursively except node_modules
alias dox="groc \`find . -name '*.coffee' ! -regex '.*node_modules.*'\`"
alias lastdir="ls -1tr | tail -1"
alias ipme="ipconfig getifaddr en0"
alias spot='mdfind -onlyin "$PWD"'
alias lock="osascript -e 'tell application \"System Events\" to sleep'"


relpath () {
    [ $# -ge 1 ] && [ $# -le 2 ] || return 1
    current="${2:+"$1"}"
    target="${2:-"$1"}"
    [ "$target" != . ] || target=/
    target="/${target##/}"
    [ "$current" != . ] || current=/
    current="${current:="/"}"
    current="/${current##/}"

    appendix="${target##/}"
    relative=''
    while appendix="${target#"$current"/}"
        [ "$current" != '/' ] && [ "$appendix" = "$target" ]; do
        if [ "$current" = "$appendix" ]; then
            relative="${relative:-.}"
            echo "${relative#/}"
            return 0
        fi
        current="${current%/*}"
        relative="$relative${relative:+/}.."
        echo current
        echo $appendix
        echo $relative
    done
    relative="$relative${relative:+${appendix:+/}}${appendix#/}"
    echo "$relative"
}
# Given two file names will find the path of each file and then determine
# the relative path of the second file to the first

relPathFiles () {
  (find . -iname $1 ; find . -iname $2) | xargs -n2 bash -cil 'relpath "$1" "$2"' arg0
}


function pls {
  ls -la | grep -v '^d' | grep -v 'total'| awk '{print $NF}' | fzf --preview="head -$LINES {}"
}

function pport {
  lsof -P -i -sTCP:LISTEN | grep LISTEN | fzf -m $FZF_COMPLETION_OPTS --preview "echo {} | tr -s ' ' | cut -d ' ' -f 2 | xargs lsof -p | grep cwd "
}
export PATH="/usr/local/sbin:$PATH"

export NVM_DIR="/Users/jake/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
