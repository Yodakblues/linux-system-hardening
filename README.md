# Linux System Hardening - `linsecure.sh`

## Overview
This script automates security hardening for Linux systems, implementing industry best practices such as:

- Disabling root SSH login
- Enforcing password policies
- Removing unused packages/services
- Enabling firewalls
- Logging all actions
- Backing up modified configuration files

## Why?
Properly hardening a Linux system reduces attack surfaces and ensures baseline security before system deployment.

## How to Use
```bash
chmod +x linsecure.sh
sudo ./linsecure.sh

All actions are logged in logs/hardening.log.

Author

Yodakblues — Linux & Cybersecurity Enthusiast


## 📌 1.3 Create the Directory Structure

```bash
mkdir logs
mkdir backup
touch linsecure.sh
