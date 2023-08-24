locals {
  certs_path = "${path.root}/.certs"
}
resource "null_resource" "certs" {
  provisioner "local-exec" {
    command = <<EOF
      rm -rf ${local.certs_path} &&
      mkdir -p ${local.certs_path} &&
      mkcert -install -key-file=${local.certs_path}/tls.key -cert-file=${local.certs_path}/tls.crt \
        ${var.domain} *.${var.domain}
    EOF
  }
}
data "local_file" "tls_key" {
  filename = "${local.certs_path}/tls.key"
  depends_on = [
    null_resource.certs
  ]
}
data "local_file" "tls_crt" {
  filename = "${local.certs_path}/tls.crt"
  depends_on = [
    null_resource.certs
  ]
}

module "certs" {
  source = "../../kubernetes/synced-secret"
  name   = "wildcard-tls"
  data = {
    "tls.key" = data.local_file.tls_key.content
    "tls.crt" = data.local_file.tls_crt.content
  }
  type = "kubernetes.io/tls"
}
