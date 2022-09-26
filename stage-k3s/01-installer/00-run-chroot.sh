# Get the latest version of the installation script
curl -o /tmp/get-k3s-io.sh https://get.k3s.io/
chmod +x /tmp/get-k3s-io.sh

# Install K3S using the script
INSTALL_K3S_SKIP_START=true /tmp/get-k3s-io.sh