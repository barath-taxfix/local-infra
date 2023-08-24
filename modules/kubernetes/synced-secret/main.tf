resource "kubernetes_secret" "this" {
  lifecycle {
    ignore_changes = [metadata.0.annotations, metadata.0.labels]
  }
  metadata {
    name      = var.name
    namespace = "default"
    annotations = {
      "kubed.appscode.com/sync" : ""
    }
  }
  data = var.data
  type = var.type
}
