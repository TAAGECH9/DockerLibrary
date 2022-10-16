# TF Cloud Variables
variable "client_id" {}
variable "client_secret" {}
variable "subscription_id" {}
variable "tenant_id" {}


variable "docker_rg" {
    type = map(string)
}

variable "acr" {
    type = map(string)
}
