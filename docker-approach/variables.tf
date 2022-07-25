variable "my_pub_key" {
  type = string
  description = "The public key used to ssh on the vm"
}


variable "server_instance_type" {
  type = string
  description = "Determines the CPUs and RAMs size of the vm"
}

variable "ami_value" {
    type = string
    description = "Amazon Machine Image"
}
