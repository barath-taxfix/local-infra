locals {
  domain      = "${var.cluster_name}.localhost"
  kube_config = module.cluster.credentials
}
provider "helm" {
  kubernetes {
    client_certificate     = local.kube_config["client_certificate"]
    cluster_ca_certificate = local.kube_config["cluster_ca_certificate"]
    host                   = local.kube_config["endpoint"]
    client_key             = local.kube_config["client_key"]
  }
}
provider "kubernetes" {
  client_certificate     = local.kube_config["client_certificate"]
  cluster_ca_certificate = local.kube_config["cluster_ca_certificate"]
  host                   = local.kube_config["endpoint"]
  client_key             = local.kube_config["client_key"]
}
module "cluster" {
  source       = "../../modules/local/kind-cluster"
  cluster_name = var.cluster_name
}
module "tls" {
  depends_on = [module.cluster]
  source     = "../../modules/local/tls"
  domain     = local.domain
}
module "kubernetes_base" {
  depends_on = [module.cluster]
  source     = "../../modules/kubernetes/base"
  domain     = local.domain
}
