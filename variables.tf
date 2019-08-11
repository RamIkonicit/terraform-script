variable "subnet_id" {
        default = "subnet-08f84961347b05486"
}

variable "ami_id" {
  default = "ami-0f4715e000cae4b68"
}

variable "jenkins_instance_type" {
  default = "t2.micro"
}

variable "micro_instance_type" {
  default = "t2.medium"
}

variable "availability_zones" {
  default = "us-east-2a"
}

variable "key" {
  default = "tracrat-prod-config"
}

variable "add_public_ip_address" {
  default = "true"
}

variable "root_volume_size" {
  default = "8"
}

variable "swap_volume_size" {
  default = "8"
}

variable "swap_volume_devicename" {
  default = "/dev/sdb"
}

variable "hostname" {
 default = "jenkins"
}

variable "micro_hostname" {
 default = "micro-services"
}

variable "vpc_id" {
  default = "vpc-0c4966f88f56a75ac"
}
