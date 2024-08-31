abbr -a vim nvim
abbr svim sudo nvim
alias dotfiles="cd ~/.dotfiles"
alias dc="docker compose"
abbr -a jc sudo journalctl -xe
abbr -a sf source ~/.config/fish/config.fish
command -v rg &>/dev/null && alias rgih="rg --no-ignore --hidden"
command -v lsd &>/dev/null && alias ls="lsd --group-directories-first" && alias ll="lsd -l" && alias la="lsd -lA"
command -v bat &>/dev/null && alias cat="bat --paging=never"
command -v journalctl &>/dev/null && alias jc='sudo journalctl -xe'
alias svenv="source .venv/bin/activate.fish"
abbr -a decode base64 -d
abbr -a hyprconf nvim ~/.config/hypr/hyprland.conf

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

# git
abbr -a g git
abbr -a gundo "git reset --soft HEAD~1"
abbr -a ga "git add"
abbr -a gaa "git add --all"
abbr -a gc "git commit -v"
abbr -a gcm --set-cursor 'git commit -m "%"'
abbr -a gca "git commit -va"
abbr -a gcam --set-cursor 'git commit -am "%"'
abbr -a gpl "git pull"
abbr -a gl "git log"
abbr -a gp "git push"
abbr -a gr "git remote"
abbr -a gra "git remote add"
abbr -a grs "git restore"
abbr -a grss "git restore --staged"
abbr -a gs "git status -s"
abbr -a gst "git status"
abbr -a gd "git diff --ignore-all-space"
abbr -a gds "git diff --staged"
abbr -a gsw "git switch"
abbr -a gco "git checkout"
abbr -a gcob "git checkout -b"
abbr -a gb "git branch"
abbr -a gsu "git submodule update --recursive --remote"
abbr -a gf "git fetch"

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
abbr -a k kubectl
abbr -a kc "kubectl create"
abbr -a kcd "kubectl create deployment"
abbr -a kcj "kubectl create job"

abbr -a kg "kubectl get"
abbr -a kgp "kubectl get pods"
abbr -a kgn "kubectl get nodes"
abbr -a kgd "kubectl get deployments"
abbr -a kgj "kubectl get jobs"
abbr -a kgcj "kubectl get cronjobs"

abbr -a kd "kubectl describe"
abbr -a kdd "kubectl describe deployment"
abbr -a kdp "kubectl describe pod"
abbr -a kdj "kubectl describe job"
abbr -a kdcj "kubectl describe cronjob"

abbr -a kl "kubectl logs"
abbr -a klf "kubectl logs -f"
abbr -a ke "kubectl exec"
abbr -a keit "kubectl exec -it"
abbr -a kdel "kubectl delete"

abbr -a kcjfrom --set-cursor kubectl create job --from=cronjob/%

# Cargo
abbr -a cr "cargo run"
abbr -a crr "cargo run --release"
abbr -a cb "cargo build"
abbr -a cbr "cargo build --release"
abbr -a ca "cargo add"
abbr -a cf "cargo feature"

# Nix
if command -v nix &> /dev/null
    abbr -a nsh --set-cursor 'nix shell nixpkgs#%'
    abbr -a nrs sudo nixos-rebuild switch
    abbr -a nrsu sudo nixos-rebuild switch --upgrade
    abbr -a ns --set-cursor nix search nixpkgs %
    abbr -a ne "pushd /etc/nixos && sudo nvim configuration.nix ; popd"
    abbr -a neh "pushd /etc/nixos && sudo nvim home.nix ; popd"
    abbr -a nef "pushd /etc/nixos && sudo nvim flake.nix ; popd"
end

if command -v system-manager &> /dev/null
    abbr -a sme "pushd $HOME/.config/system-manager && nvim flake.nix ; popd"
    abbr -a sms "sudo /home/mike/.nix-profile/bin/system-manager switch --flake ~/.config/system-manager"
end
