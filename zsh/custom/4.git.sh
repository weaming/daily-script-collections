# vim: filetype=sh
# git
alias gconf="vi .git/config"
alias gamend='git commit --amend'
alias greset='git reset --hard HEAD'
alias gback='git reset --hard HEAD~'
alias gl='git lg'
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset %Cgreen(%cr)%Creset -%C(yellow)%d%Creset %s  %C(bold blue)<%an>%Creset' --abbrev-commit"

git-remove-big-files() {
    # https://gist.github.com/shennyg/1047737
    git filter-branch --index-filter "git rm -rf --cached --ignore-unmatch $@" HEAD

    echo ' Maybe you want to execute:'
    echo ''
    echo ' rm -rf .git/refs/original/ && git reflog expire --all &&  git gc --aggressive --prune'
    echo ' git push --all --prune --force'
    echo ''
    echo ' Once you pushed, all your teammates need to clone repository again'
}
git-reset-origin-same-branch() {
    git reset --hard origin/$(git rev-parse --abbrev-ref HEAD)
}

alias gcl='git clone'
alias gpl='git pull'
alias gplr='git pull --rebase'
alias gplp='git pull --prune'
alias gcl='git clone'
alias gps='git push'
alias glg='git log'
alias gs='git status'
alias gd='git diff'
alias gdc='git diff --cached'
alias gdl='git diff HEAD~'
alias ga='git add -A'
alias gm='git commit -m'
alias gma='git commit -am'
alias gb='git branch'
alias gc='git checkout'
alias gra='git remote add'
alias grr='git remote rm'
alias grv='git remote -v'
alias grl='git remote get-url $(git remote)'
alias grlc='grl | pbcopy'
alias gta='git tag -a -m'
alias gf='git reflog'
alias gcp='git cherry-pick'

gitignore-get()
{
    url="https://raw.githubusercontent.com/github/gitignore/master/$1.gitignore"
    type wget &>/dev/null && wget $url -O .gitignore || curl -sSL $url > .gitignore
}
git-proxy()
{
    if [ -z "$1" ]; then
        git config --get http.proxy
        git config --get https.proxy
    else
        git config --global http.proxy "$1"
        git config --global https.proxy "$1"
    fi
}
git-noproxy()
{
    git config --global --unset http.proxy
    git config --global --unset https.proxy
}
git-force-update()
{
    git fetch && git-reset-origin-same-branch
}
git-stat-username()
{
    git log --author="$1" --pretty=tformat: --numstat | awk '{ add += $1; subs += $2; loc += $1 - $2 } END { printf "added lines: %s, removed lines: %s, total lines: %s\n", add, subs, loc }' -
}
git-stat-all()
{
    git log --format='%aN' | sort -u | while read name; do echo -en "$name\t"; git log --author="$name" --pretty=tformat: --numstat | awk '{ add += $1; subs += $2; loc += $1 - $2 } END { printf "added lines: %s, removed lines: %s, total lines: %s\n", add, subs, loc }' -; done
}
git-stat-top()
{
    git log --pretty='%aN' | sort | uniq -c | sort -k1 -n -r | head -n 5
}

git-commit-with-now() {
    git commit -m "$(date +'%Y-%m-%d %X')"
}

git-rewrite-committer() {
    git filter-branch --env-filter '
        OLD_EMAIL="jiadeng@16financial.com"
        CORRECT_NAME="weaming"
        CORRECT_EMAIL="garden.yuen@gmail.com"
        if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ]
        then
            export GIT_COMMITTER_NAME="$CORRECT_NAME"
            export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
        fi
        if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ]
        then
            export GIT_AUTHOR_NAME="$CORRECT_NAME"
            export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
        fi
    ' --tag-name-filter cat -- --branches --tags
}

git-setup-project-committer() {
    script_path=~/.dotfiles/zsh/configure_git_committer.py
    name=$(python $script_path workdir name)
    rc1=$?
    email=$(python $script_path workdir email)
    rc2=$?
    if [ "$rc1" -eq 0 ] && [ "$rc2" -eq 0 ]; then
        if [ -d '.git' ] && [ ! "$name" = "$(git config user.name)" ]; then
            echo $(OK "Setup git user & email:")
            git config user.name $name
            echo "$(git config user.name)"
            git config user.email $email
            echo "$(git config user.email)"
        fi
    fi
}

git-write-committers-config() {
    script_path=~/.dotfiles/zsh/configure_git_committer.py
    python3 $script_path write_example
}

git-ignore-file-change() {
    git update-index --assume-unchanged $1
}

git-current-branch-name() {
    git rev-parse --abbrev-ref HEAD
}

git-rename-branch-local-and-remote() {
    git branch -m "$1" "$2"
    git push origin :"$1" "$2"
}
