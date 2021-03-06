# Custom aliases

alias rstrCrsr="setterm -curson on >> /etc/issue"
alias genmnt="sudo mount -o defaults,noatime,discard=async,compress-force=zstd:1,subvol=/@ /dev/nvme0n1p5 /mnt/gentoo && sudo mount -o defaults,noatime,discard=async,compress-force=zstd:1,subvol=/@home /dev/nvme0n1p5 /mnt/gentoo/home && sudo mount -o defaults,noatime,discard=async,compress-force=zstd:1,subvol=/@varLog /dev/nvme0n1p5 /mnt/gentoo/var/log && sudo mount -o defaults,noatime,discard=async,compress-force=zstd:1,subvol=/@snapshots /dev/nvme0n1p5 /mnt/gentoo/.snapshots && sudo mount --types proc /proc /mnt/gentoo/proc && sudo mount --rbind /sys /mnt/gentoo/sys && sudo mount --make-rslave /mnt/gentoo/sys && sudo mount --rbind /dev/mnt/gentoo/dev && sudo mount --make-rslave /mnt/gentoo/dev && sudo cp --dereference /etc/resolv.conf /mnt/gentoo/etc/resolv.conf && sudo mount -t tmpfs /mnt/gentoo/var/tmp/portage -o size=24G,uid=portage,gid=portage,mode=775,nosuid,noatime,nodev"
alias btm="btm -f -g --disable_click --mem_as_value"
alias kinstall="sudo mount /boot && sudo mv /boot/EFI/Gentoo/vmlinuz.efi /boot/EFI/Gentoo/vmlinuz-old.efi && sudo cp arch/x86_64/boot/bzImage /boot/EFI/Gentoo/vmlinuz.efi && sudo umount /boot" 
alias kcompile="sudo make -j8 -s && sudo make modules_install -j8 -s && kinstall && sudo emerge @module-rebuild" 
alias archmnt="sudo mount -o defaults,noatime,discard=async,subvol=@root /dev/nvme0n1p4 /mnt/arch/ && sudo mount -o defaults,noatime,discard=async,subvol=@home /dev/nvme0n1p4 /mnt/arch/home && sudo mount -o defaults,noatime,discard=async,subvol=@opt /dev/nvme0n1p4 /mnt/arch/opt && sudo mount -o defaults,noatime,discard=async,subvol=@var /dev/nvme0n1p4 /mnt/arch/var && sudo mount --types proc /proc /mnt/arch/proc && sudo mount --rbind /sys /mnt/arch/sys && sudo mount --make-rslave /mnt/arch/sys && sudo mount --rbind /dev /mnt/arch/dev && sudo mount --make-rslave /mnt/arch/dev && test -L /dev/shm && rm /dev/shm && mkdir /dev/shm && sudo mount --types tmpfs --options nosuid,nodev,noexec shm /dev/shm && sudo chmod 1777 /dev/shm && sudo cp --dereference /etc/resolv.conf /mnt/arch/etc/resolv.conf"

alias e='$EDITOR'
alias ls='exa --icons'
alias ll='ls -l'
alias la='ls -a'
alias z='devour zathura'
alias f='devour feh'
alias m='devour prime-run mpv'
alias c='bat'
alias bat='bat --theme OneHalfDark'
alias make='make -j8'
alias dot='--git-dir=~/build/dotfiles --work-tree=~/'
alias se='sudo -E $EDITOR'

# Git Aliases

alias g='git'
alias gi='git init'
alias gst='git status'
alias gc='git commit -a'
alias ga='git add'
alias gapl='git apply'
alias gpl='git pull'
# alias gpo='git pull origin'
alias gpu='git push'
# alias gpuo='git push origin'
alias gd='git diff'
alias gch='git checkout'
alias gnb='git checkout -b'
alias gac='git add . && git commit'
alias grs='git restore --staged .'
alias gre='git restore'
alias gr='git remote'
alias gcl='git clone'
alias glg="git log --graph --abbrev-commit --decorate --format=format:'%C(bold green)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold yellow)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all"
alias gt='git ls-tree -r master --name-only'
alias grm='git remote'
alias gb='git branch'
alias gm='git merge'
alias gf='git fetch'

# Dotfiles
alias d='git --git-dir=$HOME/build/dotfiles --work-tree=$HOME'
alias dst='git --git-dir=$HOME/build/dotfiles --work-tree=$HOME status'
alias dc='git --git-dir=$HOME/build/dotfiles --work-tree=$HOME commit -a'
alias da='git --git-dir=$HOME/build/dotfiles --work-tree=$HOME add'
alias dapl='git --git-dir=$HOME/build/dotfiles --word-tree=$HOME apply'
alias dpl='git --git-dir=$HOME/build/dotfiles --work-tree=$HOME pull'
# alias gpo='git pull origin'
alias dpu='git --git-dir=$HOME/build/dotfiles --work-tree=$HOME push'
# alias gpuo='git push origin'
alias ddi='git --git-dir=$HOME/build/dotfiles --work-tree=$HOME diff'
alias dch='git --git-dir=$HOME/build/dotfiles --work-tree=$HOME checkout'
alias dnb='git --git-dir=$HOME/build/dotfiles --work-tree=$HOME checkout -b'
alias dac='git --git-dir=$HOME/build/dotfiles --work-tree=$HOME add . && git --git-dir=$HOME/build/dotfiles --work-tree=$HOME commit'
alias drs='git --git-dir=$HOME/build/dotfiles --work-tree=$HOME restore --staged .'
alias dre='git --git-dir=$HOME/build/dotfiles --work-tree=$HOME restore'
alias dr='git --git-dir=$HOME/build/dotfiles --work-tree=$HOME remote'
alias dlg="git --git-dir=$HOME/build/dotfiles --work-tree=$HOME log --graph --abbrev-commit --decorate --format=format:'%C(bold green)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold yellow)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all"
alias dt='git --git-dir=$HOME/build/dotfiles --work-tree=$HOME ls-tree -r master --name-only'
alias drm='git --git-dir=$HOME/build/dotfiles --work-tree=$HOME remote'
alias db='git --git-dir=$HOME/build/dotfiles --work-tree=$HOME branch'
alias dm='git --git-dir=$HOME/build/dotfiles --work-tree=$HOME merge'
alias dfe='git --git-dir=$HOME/build/dotfiles --work-tree=$HOME fetch'
alias cpGentooFiles='rm -rf ~/build/gentooFiles/* && cp /etc/portage/make.conf ~/build/gentooFiles/ && cp /etc/portage/package.accept_keywords ~/build/gentooFiles/ && cp /etc/portage/package.license ~/build/gentooFiles/ && cp /etc/portage/package.unmask ~/build/gentooFiles/ && cp -r /etc/portage/package.mask ~/build/gentooFiles/ && cp -r /etc/portage/package.use ~/build/gentooFiles/ && cp -r /etc/portage/patches ~/build/gentooFiles/ && cp -r /etc/portage/savedconfig ~/build/gentooFiles/ && cp -r /etc/portage/repos.conf ~/build/gentooFiles/ && cp /var/lib/portage/world ~/build/gentooFiles/pkgList && cp /usr/src/linux/.config ~/build/gentooFiles/Kconfig'
