#!/usr/bin/env bash
#
# Script to check and install Ansible, Vagrant, and VirtualBox
# Compatible with Debian/Ubuntu, RHEL/Fedora/CentOS, and Arch Linux.

set -euo pipefail

# 1. Ensure the script is run with sudo/root privileges
if [[ $EUID -ne 0 ]]; then
   echo "Error: This script must be run as root or with sudo." >&2
   exit 1
fi

# 2. Detect Linux Distribution
detect_distro() {
    if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        DISTRO_ID=$ID
        DISTRO_LIKE=${ID_LIKE:-""}
    else
        echo "Error: Cannot detect Linux distribution (/etc/os-release not found)." >&2
        exit 1
    fi

    if [[ "$DISTRO_ID" =~ ^(ubuntu|debian)$ ]] || [[ "$DISTRO_LIKE" =~ (ubuntu|debian) ]]; then
        FLAVOR="debian"
    elif [[ "$DISTRO_ID" =~ ^(fedora|rhel|centos|rocky|almalinux)$ ]] || [[ "$DISTRO_LIKE" =~ (fedora|rhel|centos) ]]; then
        FLAVOR="redhat"
    elif [[ "$DISTRO_ID" =~ ^(arch|manjaro)$ ]] || [[ "$DISTRO_LIKE" =~ arch ]]; then
        FLAVOR="arch"
    else
        echo "Error: Unsupported Linux distribution family '$DISTRO_ID'." >&2
        exit 1
    fi

    echo "Detected OS family: $FLAVOR"
}

# 3. Helper function to check command presence
is_installed() {
    command -v "$1" &>/dev/null
}

# 4. Installation Functions per Package & OS
install_ansible() {
    echo "--> Installing Ansible..."
    case "$FLAVOR" in
        debian)
            apt-get update -y
            apt-get install -y ansible
            ;;
        redhat)
            if command -v dnf &>/dev/null; then
                dnf install -y epel-release || true
                dnf install -y ansible
            else
                yum install -y epel-release || true
                yum install -y ansible
            fi
            ;;
        arch)
            pacman -Sy --noconfirm ansible
            ;;
    esac
}

install_vagrant() {
    echo "--> Installing Vagrant..."
    case "$FLAVOR" in
        debian)
            apt-get update -y
            apt-get install -y vagrant
            ;;
        redhat)
            if command -v dnf &>/dev/null; then
                dnf install -y vagrant
            else
                yum install -y vagrant
            fi
            ;;
        arch)
            pacman -Sy --noconfirm vagrant
            ;;
    esac
}

install_virtualbox() {
    echo "--> Installing VirtualBox..."
    case "$FLAVOR" in
        debian)
            apt-get update -y
            apt-get install -y virtualbox
            ;;
        redhat)
            if command -v dnf &>/dev/null; then
                dnf install -y virtualbox
            else
                yum install -y virtualbox
            fi
            ;;
        arch)
            pacman -Sy --noconfirm virtualbox
            ;;
    esac
}

# 5. Main Logic
main() {
    detect_distro
    echo "-------------------------------------"

    # Check Ansible
    if is_installed ansible; then
        echo "[✓] Ansible is already installed."
    else
        echo "[X] Ansible is missing."
        install_ansible
    fi

    # Check Vagrant
    if is_installed vagrant; then
        echo "[✓] Vagrant is already installed."
    else
        echo "[X] Vagrant is missing."
        install_vagrant
    fi

    # Check VirtualBox
    if is_installed VBoxManage || is_installed virtualbox; then
        echo "[✓] VirtualBox is already installed."
    else
        echo "[X] VirtualBox is missing."
        install_virtualbox
    fi

    echo "-------------------------------------"
    echo "All checks and installations complete!"
}

main "$@"
