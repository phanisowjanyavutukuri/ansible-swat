mv $HOSTNAME-key.pem $HOSTNAME.pem /var/lib/kubelet/
mv $HOSTNAME.kubeconfig /var/lib/kubelet/kubeconfig
mv ca.pem /var/lib/kubernetes/

cat <<EOF | sudo tee /var/lib/kubelet/kubelet-config.yaml
kind: KubeletConfiguration
apiVersion: kubelet.config.k8s.io/v1beta1
authentication:
  anonymous:
    enabled: false
  webhook:
    enabled: true
  x509:
    clientCAFile: "/var/lib/kubernetes/ca.pem"
authorization:
  mode: Webhook
clusterDomain: "cluster.local"
clusterDNS:
  - "10.32.0.10"
podCIDR: "10.244.0.0/16"
resolvConf: "/run/systemd/resolve/resolv.conf"
runtimeRequestTimeout: "15m"
tlsCertFile: "/var/lib/kubelet/$HOSTNAME.pem"
tlsPrivateKeyFile: "/var/lib/kubelet/$HOSTNAME-key.pem"
EOF
