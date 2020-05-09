provider "aws" {
      profile    = "default"
      region     = "us-east-2"
      access_key = "AKIATP7GQV7UZ33BEU7X"
      secret_key = "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"
}

resource "aws_instance" "tracrat-dev-server" {
  ami = "${var.ami_id}"
  instance_type = "${var.dev_instance_type}"
  availability_zone = "${var.availability_zones}"
  security_groups = ["${aws_security_group.terraform-ec2-server_security_group.id}"]
  #subnet_id = "${var.subnet_id}"
  user_data = "${file("script1.sh")}"
  associate_public_ip_address = "${var.add_public_ip_address}"
  tags = {
    Name = "${var.hostname}"
       }
  key_name = "${var.key}"
  root_block_device {
    volume_size           = "${var.root_volume_size}"
  }
}

#resource "aws_eip" "eip_new" {
 # vpc = true
#}

#resource "aws_eip_association" "eip_assoc" {
 # instance_id   = "${aws_instance.jenkins.id}"
 # allocation_id = "${aws_eip.eip_new.id}"
#}

resource "aws_security_group" "terraform-ec2-server_security_group" {
        name = "terraform-ec2-server security group"
        description = "This is a terraform-ec2-server Instance security group"
        vpc_id = "${var.vpc_id}"

ingress {
        protocol = "tcp"
        from_port   = "1433"
        to_port     = "1433"
        cidr_blocks = ["18.223.240.65/32"]
}

ingress {
        protocol = "tcp"
        from_port   = "9000"
        to_port     = "9000"
        cidr_blocks = ["18.223.240.65/32"]
}

ingress {
        protocol = "tcp"
        from_port   = "8080"
        to_port     = "8080"
        cidr_blocks = ["18.223.240.65/32"]
}

ingress {
        from_port = "80"
        to_port = "80"
        protocol = "tcp"
        cidr_blocks = ["18.223.240.65/32"]
}

ingress {
        from_port = "4200"
        to_port = "4200"
        protocol = "tcp"
        cidr_blocks = ["18.223.240.65/32"]
}
ingress {
        from_port = "22"
        to_port = "22"
        protocol = "tcp"
        cidr_blocks = ["18.223.240.65/32"]
}

ingress {
        from_port = "443"
        to_port = "443"
        protocol = "tcp"
        cidr_blocks = ["18.223.240.65/32"]

}

egress {
    protocol = "-1"
    from_port   = "0"
    to_port     = "0"
    cidr_blocks = ["0.0.0.0/0"]
}
 }

output "terraform-ec2-server_ip_is" {
  value = "${var.add_public_ip_address}"
}

