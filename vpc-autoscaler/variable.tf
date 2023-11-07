variable "region" {
  type = string
  default = "us-east-1"

}

variable "public_subnet_cidr" {
  type = list(string)
  default = ["10.0.5.0/24", "10.0.6.0/24"]

}

variable "azs" {
  type = list(string)
  default = ["us-east-1c", "us-east-1e"]

}

