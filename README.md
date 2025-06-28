# nethunter_rootles
**{nethunter}**

## kali-on-android-proot

Run Kali Linux Inside Android (Without Root) via PRoot-Debian

This project provides a fully automated shell script to install Kali Linux tools on modern Android devices using Termux + PRoot + Debian. It bypasses NetHunter's limitations and delivers a reproducible Kali-ready environment without root access.

---

### Why Not Use NetHunter or Other Scripts?

Most public NetHunter scripts fail due to:

- Modern Android security: SELinux, Scoped Storage, and kernel changes break classic `chroot`, `su`, and `/dev` mounting.
- Filesystem errors: `bsdtar`/`tar` fail to create device files inside `/dev/`, causing incomplete Kali rootfs.
- QEMU or binfmt issues: Raw ARM Kali images can't run without loader support, which fails in Termux.

---

### What This Script Does

- Installs `proot-distro` from Termux.
- Installs a fresh Debian base system.
- Inside Debian:
  - Adds the Kali Linux APT repository.
  - Imports the Kali archive signing key.
  - Runs `apt update && apt upgrade`.
  - Installs Kali metapackages:
    - `kali-linux-headless`
    - `kali-linux-default`
    - (or others as needed)

---

### Features

- Works without root on Android 10 and above
- Secure: No dangerous permissions required
- Lightweight base with optional toolsets
- Supports customization (e.g. XFCE/VNC GUI)
- All files persist under Termux storage

---

### Usage

```bash
# Step 1: Download and run the installer directly from GitHub
curl -LO https://raw.githubusercontent.com/0x5396479/nethunter_rootles/main/nethunter_rootles.sh
chmod +x nethunter_rootles.sh
./nethunter_rootles.sh

---

# Step 2: Launch Debian with Kali tools
proot-distro login debian

---

apt install xfce4 xfce4-goodies tightvncserver -y
