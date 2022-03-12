 variable "vm_small_size" {
  type = string
  description = "Size of the small machines"
  default = "Standard_DS1_v2"
}

variable "vm_big_size" {
  type = string
  description = "Size of the big machines"
  default = "Standard_B2s"
}

 variable "small_machines" {
  description = "VM's small machine to create"
  type = list(string)
  default = ["worker02", "nfs"] # [worker02 = ansible controller, nfs = nfs]
}

variable "big_machines" {
  description = "VM's big machine to create"
  type = list(string)
  default = ["master", "worker01"] # [master = K8Master, worker01 = K8Worker]
}
