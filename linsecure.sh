#!/bin/bash

# linsecure.sh - Linux System Hardening Script
# Author: Yodakblues
# Date: $(20-05-2025)
# Description: Applies basic Linux security hardening steps

LOGFILE="logs/hardening.log"
BACKUPDIR="backup"

log() {
  echo "$(date) - $1" | tee -a "$LOGFILE"
}

backup_file() {
  if [ -f "$1" ]; then
    cp "$1" "$BACKUPDIR/$(basename $1).bak"
    log "Backed up $1"
  fi
}

# 2.2 Disable Root SSH Login

Still in the script:

log "Disabling root SSH login..."
backup_file /etc/ssh/sshd_config

# Disable root login
sed -i 's/^PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
echo "PermitRootLogin no" >> /etc/ssh/sshd_config

systemctl restart sshd
log "Root login disabled and SSH restarted."

# 2.3 Enforce Strong Password Policies

log "Enforcing password policies..."
backup_file /etc/login.defs

# Minimum password length
sed -i 's/^PASS_MIN_LEN.*/PASS_MIN_LEN\t12/' /etc/login.defs

# Password expiry
sed -i 's/^PASS_MAX_DAYS.*/PASS_MAX_DAYS\t90/' /etc/login.defs
sed -i 's/^PASS_MIN_DAYS.*/PASS_MIN_DAYS\t10/' /etc/login.defs

log "Password policy updated."

# 2.4 Enable and Configure UFW Firewall

log "Setting up UFW firewall..."

ufw allow ssh
ufw enable

log "UFW enabled and SSH allowed."

# 2.5 Remove Unnecessary Packages

log "Removing unnecessary packages..."

UNNEEDED_PACKAGES=("telnet" "rsh-client" "xinetd")
for pkg in "${UNNEEDED_PACKAGES[@]}"; do
  if dpkg -s "$pkg" &> /dev/null; then
    apt remove -y "$pkg"
    log "$pkg removed."
  else
    log "$pkg not installed."
  fi
done


log "System hardening complete."
echo "✅ System hardening complete. Check logs/hardening.log for full output."

