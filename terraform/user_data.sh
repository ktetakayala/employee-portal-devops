#!/bin/bash

set -euo pipefail

export DEBIAN_FRONTEND=noninteractive

apt-get update

apt-get install -y \
  ca-certificates \
  curl \
  docker.io \
  unzip

systemctl enable docker
systemctl start docker

usermod -aG docker ubuntu

ARCHITECTURE="$(uname -m)"

case "${ARCHITECTURE}" in
  x86_64)
    AWS_CLI_ARCH="x86_64"
    ;;
  aarch64)
    AWS_CLI_ARCH="aarch64"
    ;;
  *)
    echo "Unsupported architecture: ${ARCHITECTURE}"
    exit 1
    ;;
esac

curl \
  --fail \
  --silent \
  --show-error \
  --location \
  "https://awscli.amazonaws.com/awscli-exe-linux-${AWS_CLI_ARCH}.zip" \
  --output /tmp/awscliv2.zip

unzip -q /tmp/awscliv2.zip -d /tmp

/tmp/aws/install --update

rm -rf /tmp/aws /tmp/awscliv2.zip

mkdir -p /opt/employee-portal

chown ubuntu:ubuntu /opt/employee-portal

cat > /etc/motd <<'EOF'
Employee Portal deployment server
Docker and AWS CLI are installed through Terraform user data.
EOF

touch /var/log/employee-portal-bootstrap-complete