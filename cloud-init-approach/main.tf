terraform {
  cloud {
    organization = "omarosman23"

    workspaces {
      name = "juno-node"
    }
  }

  required_providers {
    aws = {
      source = "hashicorp/aws"
     
    }
  }

}

provider "aws" {
  region = "us-west-2"
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQChYHQ7etlb6LdPkou+A/vjVvrUcnTIB2r6yNFe9Uo+Fiw71f7NpQhZEmYusV5Hpl3zxo6OLYJL4q6Bo8kqsppu0rQawRd9OHguiWrm9bOvlbHpcDU7czslRh+1WoVulLrrHl31JfeLATF2hOpHXE5V9UM2aPAMfCFHTGxJG7C5Yfw74trdZ8NqjCU4aUUvcjvCexzDtil64X0OU1sfMf2EBHGoV0pxU0iRLuAECFkzDEJrl45QBmUBMli9+35VTJec8MykO5boEQCL/CulJhXwSFGe28t6dLpfAr7y3Rioq+KkRQe5Pja6oH+WxBy87GQ8wJauKWGzOs8/IipMbqTl"
}


data "template_file" "user_data" {
  template = "${file("./userdata.yaml")}"
}

resource "aws_instance" "web" {
  ami           = "ami-087c17d1fe0178315"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.deployer.key_name}"
  user_data = data.template_file.user_data.rendered


  tags = {
    Name = "MyServer"
  }

 
}


output "public_ip" {
  value = aws_instance.web.public_ip
}

data "aws_vpc" "main" {
  id = "vpc-06f6608585199b584"
}


resource "aws_security_group" "sg_web" {
  name        = "sg_web"
  description = "Security Group"
  vpc_id      = data.aws_vpc.main.id
  vpc_security_group_ids = [aws_security_group.sg_web.id]

  ingress = [
    {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    security_groups = []
    self = false
  },
    {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["197.54.175.194/32"]
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    security_groups = []
    self = false
  }

]
  egress = [
    { 
    description      = "outgoing traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    prefix_list_ids = []
    security_groups = []
    self = false
  }

]

}



