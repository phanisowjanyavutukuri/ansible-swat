kubectl config set-cluster kubernetes-the-hard-way \
    --certificate-authority=ca.pem \
    --embed-certs=true \
    --server=https://10.211.0.237:6443 \
    --kubeconfig=$HOSTNAME.kubeconfig

  kubectl config set-credentials system:node:$HOSTNAME \
    --client-certificate=$HOSTNAME.pem \
    --client-key=$HOSTNAME-key.pem \
    --embed-certs=true \
    --kubeconfig=$HOSTNAME.kubeconfig

  kubectl config set-context default \
    --cluster=kubernetes-the-hard-way \
    --user=system:node:$HOSTNAME \
    --kubeconfig=$HOSTNAME.kubeconfig

  kubectl config use-context default --kubeconfig=$HOSTNAME.kubeconfig
