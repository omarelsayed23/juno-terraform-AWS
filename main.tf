provider "aws" {
	region = "us-west-2"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_instance" "web" {
    
	ami           = "ami-098e42ae54c764c35"
	instance_type = "t2.large"

    connection {
        type     = "ssh"
        user     = "ec2-user"
        private_key = file("omar-key.pem")
        host     = self.public_ip
    }

}

resource "aws_instance" "temp1" {

	ami           = "ami-098e42ae54c764c35"
	instance_type = "t2.micro"

  tags = {
    Name = "temp1"
  }


}

resource "aws_instance" "twist" {


	ami           = "ami-098e42ae54c764c35"
	instance_type = "t2.micro"

  tags = {
    Name = "twist"
  }


}


resource "aws_instance" "temp2" {
  count = 0
	ami           = "ami-098e42ae54c764c35"
	instance_type = "t2.micro"

  tags = {
    Name = "temp 2"
  }

    connection {
        type        = "ssh"
        user        = "ec2-user"
        private_key = file("omar-key.pem")
        host        = aws_instance.twist.public_ip
        timeout     = "2m"
    }


   provisioner "remote-exec" {
    inline = [
    "sudo yum install wget",
    "wget -O go_downloaded https://go.dev/dl/go1.18.4.linux-amd64.tar.gz",
    "sudo tar -C /usr/local -xzf go_downloaded",
    "echo \"export PATH=$PATH:/usr/local/go/bin\" >> ~/.bashrc",
    "sudo reboot",
    "sudo yum groupinstall Development Tools -y",
    "go install github.com/NethermindEth/juno/cmd/juno@latest",
    "go install github.com/NethermindEth/juno/cmd/juno-cli@latest",
    ]
  }
  


}





