server_instance_type = "t2.large"
my_pub_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQChYHQ7etlb6LdPkou+A/vjVvrUcnTIB2r6yNFe9Uo+Fiw71f7NpQhZEmYusV5Hpl3zxo6OLYJL4q6Bo8kqsppu0rQawRd9OHguiWrm9bOvlbHpcDU7czslRh+1WoVulLrrHl31JfeLATF2hOpHXE5V9UM2aPAMfCFHTGxJG7C5Yfw74trdZ8NqjCU4aUUvcjvCexzDtil64X0OU1sfMf2EBHGoV0pxU0iRLuAECFkzDEJrl45QBmUBMli9+35VTJec8MykO5boEQCL/CulJhXwSFGe28t6dLpfAr7y3Rioq+KkRQe5Pja6oH+WxBy87GQ8wJauKWGzOs8/IipMbqTl"
ami_value = "ami-0d70546e43a941d70"

security_groups = [{
  from_port   = 22
  name        = "Office Wifi CIDR Range"
  protocol    = "tcp"
  to_port     = 22
  cidr_blocks = ["0.0.0.0/0"] # you can replace with your office wifi outbount IP range
  }, {
  from_port   = 80
  name        = "NGINX Port"
  protocol    = "tcp"
  to_port     = 80
  cidr_blocks = ["0.0.0.0/0"]
}]
