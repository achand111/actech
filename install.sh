#!/bin/bash
# Universal installer for Python and Perl on Linux
# Works on most major distros (Debian/Ubuntu, Fedora, CentOS, Arch, openSUSE, etc.)

set -e

# Detect package manager
if command -v apt-get >/dev/null; then
    PM="apt-get"
    UPDATE="apt-get update -y"
    INSTALL="apt-get install -y"
elif command -v dnf >/dev/null; then
    PM="dnf"
    UPDATE="dnf makecache -y"
    INSTALL="dnf install -y"
elif command -v yum >/dev/null; then
    PM="yum"
    UPDATE="yum makecache -y"
    INSTALL="yum install -y"
elif command -v zypper >/dev/null; then
    PM="zypper"
    UPDATE="zypper refresh"
    INSTALL="zypper install -y"
elif command -v pacman >/dev/null; then
    PM="pacman"
    UPDATE="pacman -Sy --noconfirm"
    INSTALL="pacman -S --noconfirm"
else
    echo "❌ No supported package manager found (apt, yum, dnf, zypper, pacman)."
    exit 1
fi

echo "✅ Detected package manager: $PM"
echo "🔄 Updating package lists..."
eval $UPDATE

echo "📦 Installing Python and Perl..."
# Different distros sometimes have different package names
case "$PM" in
    apt-get)
        eval $INSTALL python3 python3-pip perl
        ;;
    dnf|yum)
        eval $INSTALL python3 python3-pip perl
        ;;
    zypper)
        eval $INSTALL python3 python3-pip perl
        ;;
    pacman)
        eval $INSTALL python python-pip perl
        ;;
esac

echo "✅ Installation complete!"
echo "🐍 Python version: $(python3 --version 2>/dev/null || echo 'Not found')"
echo "🦪 Perl version: $(perl -v | grep 'perl' || echo 'Not found')"
