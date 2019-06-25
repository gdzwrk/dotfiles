#Open files in same gVim instance by default

gvim () {
    command '/c/Program Files/vim/vim81/gvim.exe' --remote-silent "$@" &
}
gvimt () { command gvim --remote-tab-silent "$@" & }
gvimr () { command gvim --R --remote-tab-silent "$@" & }

excel()  { command /c/Program\ Files/Microsoft\ Office/root/Office16/EXCEL.exe "$@" & }
word()   { command /c/Program\ File/Microsoft\ Office/root/Office16/WINWORD.EXE "$@" & }

#Change directory using wslpath
cdw () {
    cd "$(wslpath $1)"
}

#Change directory and list
cdl () {
    cd "$1"
    ls
}

#Make and change directory in one command
mkcd () {
  mkdir "$1"
  cd "$1"
}

start () {
    powershell.exe -c "start $1"
}

# Exclude the 'mine/' directory from my ripgrepping
alias 'rg'='rg -g "!mine/*"'

alias 'cdcl'='cdw "$(powershell.exe get-clipboard)"'
alias 'cd..'='cd ..'
alias 'less'='less -FX'

#Change default ls options to -lha
alias 'ls'='ls --color'
alias 'lsa'='ls -haltr --time-style=long-iso --color'

#Command to edit & reload bashrc automagically
alias 'Eb'='vim ~/.bashrc && source ~/.bashrc && cd -'
alias 'Sb'='source ~/.bashrc && cd -'
alias 'Sz'='source ~/.zshrc && cd -'
alias 'Ev'='vim ~/.vimrc'
alias 'Eiv'='vim ~/.ideavimrc'

#Commonly used directories
alias 'dv'='dirs -v'
alias '@wfo'='cd /c/projects/wfo-server'
alias '@dev'='cd /c/dev'

#Miscellaneous
alias 'psh'='powershell.exe'
alias 'cls'='clear'
alias 'exp'='explorer.exe'
alias 'mnd'='/c/dev/_scripts/mapNetworkDrives.bat'
alias 'mountx'='sudo mount -t drvfs X: /mnt/x'
alias 'tmux'='tmux -2'
alias 'e.'='exp .'
alias 'duse'='du -h --max-depth=1|sort -h'
alias 'd2u4all'='find . -type f -print0 | xargs -0 dos2unix'

#mssql-cli common databases
alias 'cldb'='mssql-cli -S 10.192.1.106 -U sa -P Admin2193! -d antenant'
alias 'prdb'='mssql-cli -S 10.192.1.107 -U sa -P Admin2193! -d antenant'

#FZF usages
alias 'fzfp'='fzf --preview="head -$LINES {}"'

#Move up multiple directories easily
alias 'u'='cd ..'
alias 'u2'='cd ../..'
alias 'u3'='cd ../../..'
alias 'u4'='cd ../../../..'
alias 'u5'='cd ../../../../..'

#Invoke gradle wrapper
alias 'gra'='./gradlew'

lsc() {
    ls -halvr --group-directories-first --time-style=long-iso --color=always "$@" | awk '
    BEGIN {
        FPAT = "([[:space:]]*[^[:space:]]+)";
        OFS = "";
    }
    {
#        $2 = "\033[31m" $2 "\033[0m";
#        $3 = "\033[36m" $3 "\033[0m";
#        $4 = "\033[36m" $4 "\033[0m";
        $2 = "";
        $3 = "";
        $4 = "";
        $5 = "\033[31m" $5 "\033[0m" ;
        $6 = "\033[36m" $6 "\033[0m";
        $7 = "\033[36m" $7 "\033[0m";
#        $8 = "\033[31m" $8 "\033[0m";
        $8 = $8;
        print
    }
'
}

lse() {
    ls -halvr --group-directories-first --sort=extension --time-style=long-iso --color=always "$@" | awk '
    BEGIN {
        FPAT = "([[:space:]]*[^[:space:]]+)";
        OFS = "";
    }
    {
#        $2 = "\033[31m" $2 "\033[0m";
#        $3 = "\033[36m" $3 "\033[0m";
#        $4 = "\033[36m" $4 "\033[0m";
        $2 = "";
        $3 = "";
        $4 = "";
        $5 = "\033[31m" $5 "\033[0m" ;
        $6 = "\033[36m" $6 "\033[0m";
        $7 = "\033[36m" $7 "\033[0m";
#        $8 = "\033[31m" $8 "\033[0m";
        $8 = $8;
        print
    }
'
}

lst() {
    ls -halvtr --group-directories-first --time-style=long-iso --color=always "$@" | awk '
    BEGIN {
        FPAT = "([[:space:]]*[^[:space:]]+)";
        OFS = "";
    }
    {
#        $2 = "\033[31m" $2 "\033[0m";
#        $3 = "\033[36m" $3 "\033[0m";
#        $4 = "\033[36m" $4 "\033[0m";
        $2 = "";
        $3 = "";
        $4 = "";
        $5 = "\033[31m" $5 "\033[0m" ;
        $6 = "\033[36m" $6 "\033[0m";
        $7 = "\033[36m" $7 "\033[0m";
#        $8 = "\033[31m" $8 "\033[0m";
        $8 = $8;
        print
    }
'
}

#Common git commands
alias 'g'='git'
alias 'gl'='git log'
alias 'glo'='git log --pretty=oneline'
alias 'gs'='git status'
alias 'gfa'='git fetch -a'
alias 'gb'='git branch'
alias 'gba'='git branch -a'
alias 'gbd'='git branch -d'
alias 'gbD'='git branch -D'
alias 'gco'='git checkout'
alias 'gcp'='git cherry-pick'
alias 'gbwho'='git for-each-ref --format="%(committerdate) %09 %(authorname) %09 %(refname)" | sort -k5n -k2M -k3n -k4n | grep'

gct() {
    git checkout --track origin/$1
}

gbsu() {
    git checkout -b $1
    git push --set-upstream origin $1
}

gpdb() {
    git push -d origin $1
}


# Tell me about my aliases
gal() {
    echo "g    - git"
    echo ""
    echo "gl   - git log"
    echo "gs   - git status"
    echo "gf   - git fetch"
    echo "gfa  - git fetch -a"
    echo "gb   - git branch"
    echo "gba  - git branch -a"
    echo "gbd  - git branch -d"
    echo "gbD  - git branch -D"
    echo ""
    echo "gbsu - Git Branch and Set Upstream to same name"
    echo "gpdb - Git Push Delete remote Branch"
    echo ""
    echo "gco  - Git CheckOut"
    echo "gct  - Git Checkout Track existing remote"
    echo ""
    echo "gcp  - Git Cherry-Pick"
    echo ""
    echo "gbwho - whodunit"
}
