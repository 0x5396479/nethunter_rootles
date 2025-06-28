#!/data/data/com.termux/files/usr/bin/bash

set -e

echo "[*] Updating Termux packages..."
pkg update -y && pkg upgrade -y

echo "[*] Installing proot-distro..."
pkg install proot-distro -y

echo "[*] Installing Debian..."
proot-distro install debian

echo "[*] Customizing Debian to enable Kali tools..."
cat << 'EOF' > ~/.proot-distro/hooks/debian/post-install
#!/bin/bash
set -e

echo "[*] Adding Kali APT repository..."
echo "deb http://http.kali.org/kali kali-rolling main contrib non-free non-free-firmware" > /etc/apt/sources.list.d/kali.list

echo "[*] Installing gnupg and curl for key import..."
apt update && apt install -y gnupg curl

echo "[*] Importing Kali archive signing key..."
curl -fsSL https://archive.kali.org/archive-key.asc | gpg --dearmor -o /etc/apt/trusted.gpg.d/kali.gpg

echo "[*] Updating apt with Kali packages..."
apt update

echo "[*] Installing Kali metapackages..."
apt install -y kali-linux-headless kali-linux-default

echo "[*] Finished Kali setup inside Debian."
EOF

chmod +x ~/.proot-distro/hooks/debian/post-install

echo "[*] Launching Debian to finalize Kali installation..."
proot-distro login debian
