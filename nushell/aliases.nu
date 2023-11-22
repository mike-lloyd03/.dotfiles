alias vim = nvim
alias svim = sudo nvim
# alias sn = source ~/.config/nushell/config.nu
alias dotfiles = cd ~/.dotfiles
alias dc = docker compose
alias jc = sudo journalctl -xe
alias om = optimus-manager

# builtin overrides
alias du = ^du
alias cp = ^cp
alias date = ^date
alias watch = ^watch

# if (uname | str trim) == "Linux" {
    alias xcopy = xclip -rmlastnl -in -selection clipboard
    alias xpaste = xclip -out -selection clipboard
# }

# if not (which nvimpager | is-empty) {
    alias less = nvimpager -p
    alias lesss = /usr/bin/less
# }

# git
alias g = git
alias gundo = git reset --soft HEAD~1
alias ga = git add
alias gaa = git add --all
alias gc = git commit -v
alias gcm = git commit -v -m
alias gca = git commit -v --all
alias gcam = git commit -v --all -m
alias gpl = git pull
alias gl = git log
alias gp = git push
alias gr = git remote
alias gra = git remote add
alias grs = git restore
alias grss = git restore --staged
alias gs = git status -s
alias gst = git status
alias gd = git diff --ignore-all-space
alias gds = git diff --staged
alias gsw = git switch
alias gco = git checkout
alias gcob = git checkout -b
alias gb = git branch
alias gsu = git submodule update --recursive --remote
alias gf = git fetch

# systemctl
alias sc = sudo systemctl
alias scr = sudo systemctl restart
alias scstart = sudo systemctl start
alias scstop = sudo systemctl stop
alias sce = sudo systemctl enable
alias scen = sudo systemctl enable --now
alias scstat = sudo systemctl status
alias scdr = sudo systemctl daemon-reload
alias scu = systemctl --user
alias scur = systemctl --user restart
alias scustart = systemctl --user start
alias scustop = systemctl --user stop
alias scue = systemctl --user enable
alias scuen = systemctl --user enable --now
alias scustat = systemctl --user status
alias scudr = systemctl --user daemon-reload

# kubectl
alias k = kubectl
alias kc = kubectl create
alias kcd = kubectl create deployment
alias kcj = kubectl create job
alias kg = kubectl get
alias kgp = kubectl get pods
alias kgn = kubectl get nodes
alias kgd = kubectl get deployments
alias kgj = kubectl get jobs
alias kgcj = kubectl get cronjobs
alias kd = kubectl describe
alias kdd = kubectl describe deployments
alias kdp = kubectl describe pods
alias kdn = kubectl describe nodes
alias kl = kubectl logs
alias ke = kubectl exec
alias keit = kubectl exec -it
alias kdl = kubectl delete
