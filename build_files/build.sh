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

# install -Dm0755 /ctx/usr/local/bin/validate-ai-agent-deps /usr/local/bin/validate-ai-agent-deps
# install -Dm0755 /ctx/usr/local/bin/install-ai-brew-packages /usr/local/bin/install-ai-brew-packages
# install -Dm0644 /ctx/usr/lib/systemd/system/ai-brew-packages.service /usr/lib/systemd/system/ai-brew-packages.service

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable podman.socket
# systemctl enable ai-brew-packages.service
