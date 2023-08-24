resource "kind_cluster" "this" {
  wait_for_ready  = true
  name            = var.cluster_name
  kubeconfig_path = pathexpand("~/.kube/config")
  node_image      = "kindest/node:v1.26.0"
  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"
    node {
      role = "control-plane"
      kubeadm_config_patches = [
        yamlencode({
          kind = "InitConfiguration"
          nodeRegistration = {
            kubeletExtraArgs = {
              "node-labels" = "ingress-ready=true"
            }
          }
        })
      ]
      extra_port_mappings {
        container_port = 80
        host_port      = 80
        listen_address = "0.0.0.0"
      }
      extra_port_mappings {
        container_port = 443
        host_port      = 443
        listen_address = "0.0.0.0"
      }
    }
    dynamic "node" {
      for_each = range(var.worker_nodes)
      content {
        role = "worker"
        kubeadm_config_patches = [
          yamlencode({
            kind = "JoinConfiguration"
            nodeRegistration = {
              kubeletExtraArgs = {
                system-reserved : "memory=2Gi,cpu=1"
              }
            }
          })
        ]
      }
    }
  }
}
