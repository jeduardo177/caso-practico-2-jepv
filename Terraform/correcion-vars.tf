variable "location" {
  type = string
  description = "Azure region where we will create the infrastructure"
  default = "West Europe"
}

variable "storage_account" {
  type = string
  description = "Name for the storage account"
  default = "staccountjepvcp2"
}

variable "public_key_path" {
  type = string
  description = "Path for the public key to access the instances"
  default = "~/.ssh/id_rsa.pub"
}

variable "ssh_user" {
  type = string
  description = "User to ssh"
  default = "jeduardo177"
}
