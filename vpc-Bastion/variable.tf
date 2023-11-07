variable "region" {
  type = string
  default = "us-east-1"

}


variable "public_subnet_cidr" {
  type = list(string)
  default = ["192.168.1.0/24", "192.168.2.0/24"]

}

variable "azs" {
  type = list(string)
  default = ["us-east-1c", "us-east-1e"]

}