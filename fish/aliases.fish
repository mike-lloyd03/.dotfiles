alias vim=nvim
alias svim="sudo nvim"
alias sn="source ~/.config/nushell/config.nu"
alias dotfiles="cd ~/.dotfiles"
alias nixfiles="cd ~/.nixfiles"
alias dc="docker compose"
alias jc="sudo journalctl -xe"
alias om=optimus-manager
alias sf="source ~/.config/fish/config.fish"
command -v rg &>/dev/null && alias rgih="rg --no-ignore --hidden"
command -v lsd &>/dev/null && alias ls="lsd --group-directories-first" && alias ll="lsd -l" && alias la="lsd -la"
command -v bat &>/dev/null && alias cat="bat --paging=never"
command -v journalctl &>/dev/null && alias jc='sudo journalctl -xe'
alias svenv="source .venv/bin/activate.fish"
alias decode="base64 -d"

function last_history_item
    echo $history[1]
end
abbr -a !! --position anywhere --function last_history_item

if [ (uname) = "Linux" ]
    alias xcopy="xclip -rmlastnl -in -selection clipboard"
    alias xpaste="xclip -out -selection clipboard"
end

if command -v nvimpager &> /dev/null
    alias less="nvimpager"
    alias lesss="/usr/bin/less"
end

if [ "$(uname -n)" = TD-C02FK3H8MD6T ]
    alias kdev='kubectl config use-context appsec-dev'
    alias kprod='kubectl config use-context appsec-prod'
    alias pip="pip3"
    alias python="python3"
    alias release='~/go/src/github.td.teradata.com/Application-Security/shared/common/release.sh'
    alias sed=gsed
    alias grep=ggrep
end

if [ "$(uname -n)" = dev ]
    alias kdevr='kubectl config use-context appsec-dev-rancher'
    alias kdev='kubectl config use-context appsec-dev'
    alias kprodr='kubectl config use-context appsec-prod-rancher'
    alias kprod="kubectl config use-context appsec-prod"
    alias klogin="kubectl vsphere login --server=10.22.24.2  --insecure-skip-tls-verify --vsphere-username ml255064@td.teradata.com --tanzu-kubernetes-cluster-name appsec-prod --tanzu-kubernetes-cluster-namespace appsec-ns"
    alias klogindev="kubectl vsphere login --server=10.22.24.2  --insecure-skip-tls-verify --vsphere-username ml255064@td.teradata.com --tanzu-kubernetes-cluster-name appsec-dev --tanzu-kubernetes-cluster-namespace appsec-ns"
    alias ac=armorcode
    alias gh="GITHUB_ENTERPRISE_TOKEN='' /usr/bin/gh"
end

# git
alias g=git
alias gundo="git reset --soft HEAD~1"
alias ga="git add"
alias gaa="git add --all"
alias gc="git commit -v"
alias gcm="git commit -v -m"
alias gca="git commit -v --all"
alias gcam="git commit -v --all -m"
alias gpl="git pull"
alias gl="git log"
alias gp="git push"
alias gr="git remote"
alias gra="git remote add"
alias grs="git restore"
alias grss="git restore --staged"
alias gs="git status -s"
alias gst="git status"
alias gd="git diff --ignore-all-space"
alias gds="git diff --staged"
alias gsw="git switch"
alias gco="git checkout"
alias gcob="git checkout -b"
alias gb="git branch"
alias gsu="git submodule update --recursive --remote"
alias gf="git fetch"

# systemctl
alias sc="sudo systemctl"
alias scr="sudo systemctl restart"
alias scstart="sudo systemctl start"
alias scstop="sudo systemctl stop"
alias sce="sudo systemctl enable"
alias scen="sudo systemctl enable --now"
alias scstat="sudo systemctl status"
alias scdr="sudo systemctl daemon-reload"
alias scu="systemctl --user"
alias scur="systemctl --user restart"
alias scustart="systemctl --user start"
alias scustop="systemctl --user stop"
alias scue="systemctl --user enable"
alias scuen="systemctl --user enable --now"
alias scustat="systemctl --user status"
alias scudr="systemctl --user daemon-reload"

# kubectl
alias k=kubectl
alias kc="kubectl create"
alias kcd="kubectl create deployment"
alias kcj="kubectl create job"

alias kg="kubectl get"
alias kgp="kubectl get pods"
alias kgn="kubectl get nodes"
alias kgd="kubectl get deployments"
alias kgj="kubectl get jobs"
alias kgcj="kubectl get cronjobs"

alias kd="kubectl describe"
alias kdd="kubectl describe deployment"
alias kdp="kubectl describe pod"
alias kdj="kubectl describe job"
alias kdcj="kubectl describe cronjob"

alias kl="kubectl logs"
alias klf="kubectl logs -f"
alias ke="kubectl exec"
alias keit="kubectl exec -it"
alias kdel="kubectl delete"

abbr -a kcjfrom --set-cursor kubectl create job --from=%

# Cargo
alias cr="cargo run"
alias crr="cargo run --release"
alias cb="cargo build"
alias cbr="cargo build --release"
alias ca="cargo add"
alias cf="cargo feature"
