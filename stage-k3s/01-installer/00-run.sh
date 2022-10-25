
# Get the latest version of the installation script
on_chroot << EOF
curl -o /tmp/get-k3s-io.sh https://get.k3s.io/
chmod +x /tmp/get-k3s-io.sh
EOF

# Install K3S using the script

if [[ "${CLUSTER_INIT}"  == "true" ]]; then
    if [[ -z "${CLUSTER_SECRET}" ]]; then
        log "No CLUSTER_SECRET, aborting k3s installation in cluster mod"
    else
        if [[ "${CLUSTER_IS_MASTER}" == "true" ]]; then
            on_chroot << EOF
                INSTALL_K3S_SKIP_START=true sh -s /tmp/get-k3s-io.sh server --cluster-init
EOF
        else
            log "Edit and run script '/root/install-k3s-node.sh' when master is running."
            if [[ -z "${CLUSTER_MASTER_HOSTNAME}" ]]; then
                CLUSTER_MASTER_HOSTNAME="k3s-master"
            fi
            on_chroot << EOF
            echo "
                curl -o /tmp/get-k3s-io.sh https://get.k3s.io/
                chmod +x /tmp/get-k3s-io.sh
                INSTALL_K3S_SKIP_START=true sh -s /tmp/get-k3s-io.sh server --cluster-init
            "
EOF
        fi
    fi
else
    
fi


# Install etcd cli if k3s uses the HA cluster mode
if [[ "${CLUSTER_INIT}"  == "true" && "${INSTALL_ETCDCTL}"  == "true" ]]; then
    # Install etcdctl
    if [[ -z "${ETCDCTL_VERSION}" ]]; then
        ETCDCTL_VERSION="v3.5.0"
    fi
    on_chroot << EOF
        curl -L https://github.com/etcd-io/etcd/releases/download/${ETCDCTL_VERSION}/etcd-${ETCDCTL_VERSION}-linux-amd64.tar.gz --output etcdctl-linux-amd64.tar.gz
        tar -zxvf etcdctl-linux-amd64.tar.gz --strip-components=1 -C /usr/local/bin etcd-${ETCDCTL_VERSION}-linux-amd64/etcdctl
EOF  
fi