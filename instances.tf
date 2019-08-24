provider "aws" {
        shared_credentials_file = "/tmp/credentials"
        region     = "us-east-2"
}

resource "aws_instance" "jenkins" {
  ami = "${var.ami_id}"
  instance_type = "${var.jenkins_instance_type}"
  availability_zone = "${var.availability_zones}"
  security_groups = ["${aws_security_group.jenkins_security_group.id}"]
  subnet_id = "${var.subnet_id}"
  user_data = "${file("script.sh")}"
  associate_public_ip_address = "${var.add_public_ip_address}"
  tags = {
    Name = "${var.hostname}"
       }
  key_name = "${var.key}"
  root_block_device {
    volume_size           = "${var.root_volume_size}"
  }
}

resource "aws_ebs_volume" "swapvolume" {
    availability_zone = "${var.availability_zones}"
    size = "${var.swap_volume_size}"
}

resource "aws_volume_attachment" "ebs_swap" {
  device_name = "${var.swap_volume_devicename}"
  volume_id   = "${aws_ebs_volume.swapvolume.id}"
  instance_id = "${aws_instance.jenkins.id}"
}

resource "aws_eip" "eip_new" {
  vpc = true
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = "${aws_instance.jenkins.id}"
  allocation_id = "${aws_eip.eip_new.id}"
}

resource "aws_security_group" "jenkins_security_group" {
        name = "jenkins security group"
        description = "This is a Jenkins Instance security group"
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

resource "aws_instance" "micro" {
  ami = "${var.micro_ami_id}"
  instance_type = "${var.micro_instance_type}"
  availability_zone = "${var.micro_availability_zones}"
  security_groups = ["${aws_security_group.micro_security_group.id}"]
  subnet_id = "${var.micro_subnet_id}"
  user_data = "${file("script1.sh")}"
  associate_public_ip_address = "${var.add_public_ip_address}"
  tags = {
    Name = "${var.micro_hostname}"
       }
  key_name = "${var.micro_key}"
  root_block_device {
    volume_size           = "${var.root_volume_size}"
  }
}

resource "aws_ebs_volume" "microvolume" {
    availability_zone = "${var.micro_availability_zones}"
    size = "${var.swap_volume_size}"
}

resource "aws_volume_attachment" "microswap" {
  device_name = "${var.swap_volume_devicename}"
  volume_id   = "${aws_ebs_volume.microvolume.id}"
  instance_id = "${aws_instance.micro.id}"
}

resource "aws_eip" "eip_again" {
  vpc = true
}

resource "aws_eip_association" "eip_assocc" {
  instance_id   = "${aws_instance.micro.id}"
  allocation_id = "${aws_eip.eip_again.id}"
}

resource "aws_security_group" "micro_security_group" {
        name = "micro security group"
        description = "This is a Micro Services security group"
        vpc_id = "${var.micro_vpc_id}"

ingress {
        protocol = "tcp"
        from_port   = "8081"
        to_port     = "8081"
        cidr_blocks = ["18.223.240.65/32"]
}

ingress {
        from_port = "8761"
        to_port = "8761"
        protocol = "tcp"
        cidr_blocks = ["18.223.240.65/32"]
}

ingress {
        from_port = "8087"
        to_port = "8087"
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
        from_port = "8085"
        to_port = "8085"
        protocol = "tcp"
        cidr_blocks = ["18.223.240.65/32"]
}

ingress {
        from_port = "8088"
        to_port = "8088"
        protocol = "tcp"
        cidr_blocks = ["18.223.240.65/32"]
}

ingress {
        from_port = "1433"
        to_port = "1433"
        protocol = "tcp"
        cidr_blocks = ["18.223.240.65/32"]
}

ingress {
        from_port = "8089"
        to_port = "8089"
        protocol = "tcp"
        cidr_blocks = ["18.223.240.65/32"]
}

ingress {
        from_port = "9000"
        to_port = "9000"
        protocol = "tcp"
        cidr_blocks = ["18.223.240.65/32"]
}

ingress {
        from_port = "80"
        to_port = "80"
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

output "jenkins_ip_is" {
  value = "${aws_eip.eip_new.public_ip}"
}

output "micro_ip_is" {
  value = "${aws_eip.eip_again.public_ip}"
}
