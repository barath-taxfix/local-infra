resource "helm_release" "config_syncer" {
  repository = "https://charts.appscode.com/stable"
  chart      = "config-syncer"
  name       = "config-syncer"
  namespace  = "kube-system"
  version    = "v0.14.0-rc.0"
}
