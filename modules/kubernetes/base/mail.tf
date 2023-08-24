resource "helm_release" "mailpit" {
  repository       = "https://jouve.github.io/charts"
  chart            = "mailpit"
  name             = "mailpit"
  namespace        = "mail"
  create_namespace = true
  values = [
    yamlencode({
      ingress = {
        enabled  = true
        hostname = "mail.${var.domain}"
        path     = "/"
      }
    })
  ]
}
