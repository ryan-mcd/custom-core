#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
dnf5 install -y tmux \
  git \
  curl \
  jq \
  ripgrep \
  ffmpeg \
  unzip \
  tar \
  gzip \
  xz \
  ca-certificates \
  uv

### Homebrew-level user-space tooling.
### Homebrew on Linux normally lives at /home/linuxbrew/.linuxbrew.
### Use the absolute brew path so this works during non-interactive image builds.

if [ -x /home/linuxbrew/.linuxbrew/bin/brew ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

  brew update
  brew install fnm

  ### Avoid analytics in a server image.
  brew analytics off || true

  ### Keep image smaller.
  brew cleanup --prune=all || true
else
  echo "ERROR: Homebrew was expected at /home/linuxbrew/.linuxbrew/bin/brew but was not found."
  exit 1
fi

# install -Dm0755 /ctx/usr/local/bin/validate-ai-agent-deps /usr/local/bin/validate-ai-agent-deps

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable podman.socket
