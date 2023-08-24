variable "name" {
  type = string
}
variable "data" {
  type = map(any)
}
variable "type" {
  type    = string
  default = "Opaque"
}
